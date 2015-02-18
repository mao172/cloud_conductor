class Pattern < ActiveRecord::Base # rubocop:disable ClassLength
  self.inheritance_column = nil

  belongs_to :blueprint, inverse_of: :patterns
  has_many :images, dependent: :destroy
  has_many :stacks

  validates :url, format: { with: URI.regexp }
  validates_presence_of :blueprint

  after_initialize do
    self.protocol ||= 'git'
  end

  before_save :execute_packer, if: -> { url_changed? || revision_changed? }

  def status
    return :ERROR if images.any? { |image| image.status == :ERROR }
    return :PROGRESS if images.any? { |image| image.status == :PROGRESS }
    :CREATE_COMPLETE
  end

  def as_json(options = {})
    super options.merge(methods: :status, except: :parameters)
  end

  def type
    super && super.to_sym
  end

  def clone_repository
    fail 'Pattern#clone_repository needs block' unless block_given?

    path = File.expand_path("./tmp/patterns/#{SecureRandom.uuid}")

    fail 'An error has occurred while git clone' unless system("git clone #{url} #{path}")

    Dir.chdir path do
      unless revision.blank?
        fail 'An error has occurred while git checkout' unless system("git checkout #{revision}")
      end
    end

    yield path
  ensure
    FileUtils.rm_r path, force: true if path
  end

  def parameters(is_include_computed = false)
    return attributes['parameters'] if is_include_computed

    parameters = JSON.parse(attributes['parameters'] || '{}').reject do |_, parameter|
      parameter['Description'] =~ /^\[computed\]/
    end

    parameters.to_json
  end

  private

  def execute_packer
    clone_repository do |path|
      metadata = load_metadata path
      roles = load_roles path
      update_metadata path, metadata

      if CloudConductor::Config.consul.options.acl
        status, stdout, stderr = systemu('consul keygen')
        fail "consul keygen failed.\n#{stderr}" unless status.success?
        self.consul_secret_key = stdout.chomp
      else
        self.consul_secret_key = ''
      end

      roles.each do |role|
        create_images role, metadata[:name], consul_secret_key
      end
    end

    true
  end

  def type?(type)
    ->(_, resource) { resource[:Type] == type }
  end

  def load_metadata(path)
    metadata_path = File.expand_path('metadata.yml', path)
    YAML.load_file(metadata_path).with_indifferent_access
  end

  def load_roles(path)
    template_path = File.expand_path('template.json', path)
    template = JSON.parse(File.open(template_path).read).with_indifferent_access

    fail 'Resources was not found' if template[:Resources].nil?

    resources = {}
    resources.update template[:Resources].select(&type?('AWS::AutoScaling::LaunchConfiguration'))
    resources.update template[:Resources].select(&type?('AWS::EC2::Instance'))

    roles = resources.map do |key, resource|
      next key if resource[:Metadata].nil?
      next key if resource[:Metadata][:Role].nil?
      resource[:Metadata][:Role]
    end
    roles.uniq
  end

  def load_parameters(path)
    template_path = File.expand_path('template.json', path)
    template = JSON.parse(File.open(template_path).read)
    template['Parameters'] || {}
  end

  def update_metadata(path, metadata)
    self.name = metadata[:name]
    self.type = metadata[:type]
    self.parameters = load_parameters(path).to_json

    Dir.chdir path do
      self.revision = `git log --pretty=format:%H --max-count=1`
      fail 'An error has occurred whild git log' if $CHILD_STATUS && $CHILD_STATUS.exitstatus != 0
    end
  end

  def create_images(role, pattern_name, consul_secret_key) # rubocop:disable MethodLength
    current_images = BaseImage.where(os: 'CentOS-6.5').map do |base_image|
      images.build(cloud: base_image.cloud, base_image: base_image, pattern: self, role: role)
    end

    parameters = {
      repository_url: url,
      revision: revision,
      pattern_name: pattern_name,
      role: role,
      consul_secret_key: consul_secret_key
    }

    CloudConductor::PackerClient.new.build(current_images, parameters) do |results|
      update_images(results)
    end
  end

  def update_images(results)
    results.each do |name, result|
      image = images.where(name: name).first
      image.status = result[:status] == :SUCCESS ? :CREATE_COMPLETE : :ERROR
      image.image = result[:image]
      image.message = result[:message]
      image.save!
    end
  end
end

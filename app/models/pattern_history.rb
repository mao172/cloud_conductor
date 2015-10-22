class PatternHistory < ActiveRecord::Base
  include PatternAccessor
  self.inheritance_column = nil

  belongs_to :blueprint_history
  belongs_to :pattern
  has_many :images, dependent: :destroy
  has_many :stacks

  validates_presence_of :blueprint_history, :pattern

  before_create :freeze_pattern
  before_create :create_images

  before_destroy :check_pattern_usage

  after_initialize do
    self.os_version ||= 'default'
  end

  def status
    if images.empty? || images.any? { |image| image.status == :ERROR }
      :ERROR
    elsif images.all? { |image| image.status == :CREATE_COMPLETE }
      :CREATE_COMPLETE
    else
      :PROGRESS
    end
  end

  def as_json(options = {})
    super({ except: :parameters, methods: :status }.merge(options))
  end

  def filtered_parameters(is_include_computed = false)
    return JSON.parse(parameters) if is_include_computed
    filtered_parameters = JSON.parse(parameters || '{}').reject do |_, param|
      param['Description'] =~ /^\[computed\]/
    end
    filtered_parameters
  end

  private

  def freeze_pattern
    clone_repository(url, revision) do |path|
      metadata = load_metadata(path)

      self.name = metadata[:name]
      self.type = metadata[:type]
      self.parameters = read_parameters(path).to_json
      self.roles = read_roles(path).join(', ')
      freeze_revision(path)
    end
  end

  def create_images
    roles.split(/,\s*/).each do |role|
      new_images = BaseImage.where(os_version: os_version).map do |base_image|
        images.build(cloud: base_image.cloud, base_image: base_image, role: role)
      end
      packer_variables = {
        pattern_name: name,
        patterns: {},
        role: role,
        consul_secret_key: blueprint_history.consul_secret_key
      }

      blueprint_history.patterns.each do |pattern|
        packer_variables[:patterns][pattern.name] = {
          url: pattern.url,
          revision: pattern.revision
        }
      end

      CloudConductor::PackerClient.new.build(new_images, packer_variables) do |results|
        update_images(results)
      end
    end
  end

  def update_images(results)
    ActiveRecord::Base.connection_pool.with_connection do
      results.each do |name, result|
        image = images.where(name: name).first
        image.status = result[:status] == :SUCCESS ? :CREATE_COMPLETE : :ERROR
        image.image = result[:image]
        image.message = result[:message]
        image.save!
      end
    end
  end

  def freeze_revision(path)
    Dir.chdir path do
      self.revision = `git log --pretty=format:%H --max-count=1`
      fail 'An error has occurred whild git log' if $CHILD_STATUS && $CHILD_STATUS.exitstatus != 0
    end
  end

  def check_pattern_usage
    fail 'Some stacks use this pattern' unless stacks.empty?
  end
end

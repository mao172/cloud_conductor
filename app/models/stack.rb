class Stack < ActiveRecord::Base # rubocop:disable ClassLength
  belongs_to :environment
  belongs_to :pattern
  belongs_to :cloud

  validates :name, presence: true, uniqueness: { scope: :cloud_id }
  validates_presence_of :environment, :pattern, :cloud

  validates_each :template_parameters, :parameters do |record, attr, value|
    begin
      JSON.parse(value) unless value.nil?
    rescue JSON::ParserError
      record.errors.add(attr, 'is malformed or invalid json string')
    end
  end

  validate do
    errors.add(:pattern, 'can\'t use pattern that contains uncompleted image') if pattern && pattern.status != :CREATE_COMPLETE
  end

  scope :in_progress, -> { where(status: :PROGRESS) }
  scope :created, -> { where(status: :CREATE_COMPLETE) }

  before_destroy :destroy_stack, unless: -> { pending? }
  before_validation :update_name
  before_save :create_stack, if: -> { ready_for_create? }
  before_save :update_stack, if: -> { ready_for_update? }

  after_initialize do
    self.template_parameters ||= '{}'
    self.parameters ||= '{}'
    self.status ||= :PENDING
  end

  attr_accessor :client
  def client
    @client || cloud.client
  end

  def update_name
    return unless environment && pattern
    system = environment.system
    self.name = "#{system.name}-#{environment.id}-#{pattern.name}"
  end

  def create_stack
    client.create_stack(name, pattern, generate_parameters)
  rescue Excon::Errors::SocketError
    self.status = :ERROR
    Log.warn "Failed to connect to #{cloud.name}"
  rescue Excon::Errors::Unauthorized, AWS::CloudFormation::Errors::InvalidClientTokenId
    self.status = :ERROR
    Log.warn "Failed to authorize on #{cloud.name}"
  rescue Net::OpenTimeout
    self.status = :ERROR
    Log.warn "Timeout has occurred while creating stack(#{name}) on #{cloud.name}"
  rescue => e
    self.status = :ERROR
    Log.warn("Create stack on #{cloud.name} ... FAILED")
    Log.warn "Unexpected error has occurred while creating stack(#{name}) on #{cloud.name}"
    Log.warn(e)
  else
    self.status = :PROGRESS
    Log.info("Create stack on #{cloud.name} ... SUCCESS")
  end

  def update_stack
    client.update_stack name, pattern, generate_parameters
  rescue Excon::Errors::SocketError
    self.status = :ERROR
    Log.warn "Failed to connect to #{cloud.name}"
  rescue Excon::Errors::Unauthorized, AWS::CloudFormation::Errors::InvalidClientTokenId
    self.status = :ERROR
    Log.warn "Failed to authorize on #{cloud.name}"
  rescue Net::OpenTimeout
    self.status = :ERROR
    Log.warn "Timeout has occurred while creating stack(#{name}) on #{cloud.name}"
  else
    self.status = :PROGRESS
    Log.info("Update stack on #{cloud.name} ... SUCCESS")
  end

  def generate_parameters
    common_parameters = {}
    common_parameters = JSON.parse(environment.platform_outputs, symbolize_names: true) if pattern.type == 'optional'
    stack_parameters = JSON.parse(template_parameters, symbolize_names: true)
    common_parameters.deep_merge(stack_parameters)
  end

  def dup
    stack = super

    stack.status = :PENDING
    stack
  end

  def platform?
    pattern && pattern.type == 'platform'
  end

  def optional?
    pattern && pattern.type == 'optional'
  end

  def exists_on_cloud?
    client.get_stack_status name
    true
  rescue
    false
  end

  %i(pending ready_for_create ready_for_update progress create_complete error).each do |method|
    define_method "#{method}?" do
      (attributes['status'] || :NIL).to_sym == method.upcase
    end
  end

  def status
    status = super
    return status && status.to_sym unless status && status.to_sym == :PROGRESS

    client.get_stack_status name if client
  rescue
    :ERROR
  end

  def events
    client.get_stack_events name if client
  rescue
    []
  end

  def outputs
    client.get_outputs name
  rescue
    {}
  end

  def destroy_stack
    client.destroy_stack name
  rescue Excon::Errors::SocketError
    Log.warn "Failed to connect to #{cloud.name}"
  rescue Excon::Errors::Unauthorized, AWS::CloudFormation::Errors::InvalidClientTokenId
    Log.warn "Failed to authorize on #{cloud.name}"
  rescue => e
    Log.warn "Unexpected error occurred while destroy stack #{name} on #{cloud.name}."
    Log.warn "  #{e.message}"
  end

  def payload
    payload = {}
    payload["cloudconductor/patterns/#{pattern.name}/attributes"] = JSON.parse(parameters, symbolize_names: true)
    payload["cloudconductor/patterns/#{pattern.name}/config"] = {
      cloudconductor: {
        backup_restore: JSON.parse(pattern.backup_config, symbolize_names: true)
      }
    }

    payload
  end
end

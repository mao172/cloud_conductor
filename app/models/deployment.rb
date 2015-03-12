class Deployment < ActiveRecord::Base
  belongs_to :environment
  belongs_to :application_history

  validates_presence_of :environment, :application_history
  validate do
    errors.add(:environment, 'status does not create_complete') if environment && environment.status != :CREATE_COMPLETE
  end

  before_save :consul_request, if: -> { status == :NOT_DEPLOYED }
  after_initialize -> { self.status ||= :NOT_DEPLOYED }

  def consul_request
    if environment.ip_address
      self.status = :PROGRESS
      deploy_application
    else
      self.status = :ERROR
    end
  end

  def deploy_application
    Thread.new do
      ActiveRecord::Base.connection_pool.with_connection do
        begin
          environment.event.sync_fire(:deploy, application_history.payload)
          environment.event.sync_fire(:spec)
          update_attributes(status: :DEPLOY_COMPLETE)
        rescue
          update_attributes(status: :ERROR)
        end
      end
    end
  rescue
    update_columns(status: :ERROR)
  end

  def dup
    deployment = super
    deployment.environment = nil
    deployment.status = :NOT_DEPLOYED
    deployment
  end
end

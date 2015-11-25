class Role < ActiveRecord::Base
  belongs_to :project
  has_many :assignment_roles, dependent: :destroy
  has_many :assignments, through: :assignment_roles
  has_many :permissions, dependent: :destroy

  validates_presence_of :name, :project

  validates :name, uniqueness: { scope: :project_id }

  before_destroy :raise_error_in_use

  scope :find_by_project_id, -> (project_id) { where(project_id: project_id) }
  scope :assigned_to, lambda { |project_id, account_id|
    joins(:assignments)
      .where(
        arel_table[:project_id].eq(project_id)
      .and(Assignment.arel_table[:account_id].eq(account_id)))
  }

  def used?
    assignments.count > 0
  end

  def raise_error_in_use
    fail 'Can\'t destroy role that is used in some account assignments.' if used?
  end

  def add_permission(model, *actions)
    actions.each do |action|
      permissions.build(model: model, action: action)
    end
  end
end

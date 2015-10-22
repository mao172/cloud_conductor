class Pattern < ActiveRecord::Base
  include PatternAccessor
  self.inheritance_column = nil

  belongs_to :project
  has_many :catalogs, dependent: :destroy
  has_many :blueprints, through: :catalogs
  has_many :histories, class_name: :PatternHistory, dependent: :destroy

  validates_presence_of :project
  validates :url, format: { with: URI.regexp }

  after_initialize do
    self.protocol ||= 'git'
  end

  before_save :freeze_pattern

  def as_json(options = {})
    super({ except: :parameters }.merge(options))
  end

  private

  def freeze_pattern
    clone_repository(url, revision) do |path|
      metadata = load_metadata(path)

      self.name = metadata[:name]
      self.type = metadata[:type]
      self.parameters = read_parameters(path).to_json
      self.roles = read_roles(path).join(', ')
    end
  end
end

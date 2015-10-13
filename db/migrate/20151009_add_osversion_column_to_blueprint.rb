class AddOsversionColumnToBlueprint < ActiveRecord::Migration
  def change
    add_column :blueprints, :os_version, :string
  end
end

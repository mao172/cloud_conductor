class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :name
      t.text :template_body
      t.string :template_url
      t.text :parameters
      t.references :primary_cloud
      t.references :secondary_cloud
      t.timestamps
    end
  end
end

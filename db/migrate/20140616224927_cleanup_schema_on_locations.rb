class CleanupSchemaOnLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :factual_id, :string
    remove_column :locations, :address2, :string
    remove_column :locations, :description, :string
    change_column :locations, :done, :boolean, null: false, default: false
  end
end

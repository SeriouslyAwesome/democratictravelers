class UpdateSchemaOnLocations < ActiveRecord::Migration
  def change
    change_column :locations, :lat, :float, null: false
    change_column :locations, :long, :float, null: false
  end
end

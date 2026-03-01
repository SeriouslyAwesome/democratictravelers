class UpdateSchemaOnLocations < ActiveRecord::Migration[4.2]
  def change
    change_column :locations, :lat, :float, null: false
    change_column :locations, :long, :float, null: false
  end
end

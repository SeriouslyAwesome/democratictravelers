class AddIndexToLocations < ActiveRecord::Migration[4.2]
  def change
    add_index :locations, :country_id
  end
end

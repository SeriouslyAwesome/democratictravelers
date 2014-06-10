class AddIndexToLocations < ActiveRecord::Migration
  def change
    add_index :locations, :country_id
  end
end

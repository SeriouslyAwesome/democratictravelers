class AddCurrentToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :current, :boolean
  end
end

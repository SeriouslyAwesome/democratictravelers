class AddCurrentToLocations < ActiveRecord::Migration[4.2]
  def change
    add_column :locations, :current, :boolean
  end
end

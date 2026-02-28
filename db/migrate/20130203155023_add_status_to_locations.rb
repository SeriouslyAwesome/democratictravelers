class AddStatusToLocations < ActiveRecord::Migration[4.2]
  def change
    add_column :locations, :status, :boolean
  end
end

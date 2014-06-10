class AddStatusToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :status, :boolean
  end
end

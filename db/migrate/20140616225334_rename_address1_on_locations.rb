class RenameAddress1OnLocations < ActiveRecord::Migration[4.2]
  def change
    rename_column :locations, :address1, :address
  end
end

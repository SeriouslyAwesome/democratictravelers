class RenameAddress1OnLocations < ActiveRecord::Migration
  def change
    rename_column :locations, :address1, :address
  end
end

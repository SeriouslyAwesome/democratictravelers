class RenameStatusColumnOnLocations < ActiveRecord::Migration
  def change
    rename_column :locations, :status, :done
  end
end

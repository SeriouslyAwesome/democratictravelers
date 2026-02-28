class RenameStatusColumnOnLocations < ActiveRecord::Migration[4.2]
  def change
    rename_column :locations, :status, :done
  end
end

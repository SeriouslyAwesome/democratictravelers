class AddPositionToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :position, :integer

    add_column :assets, :cover, :boolean

  end
end

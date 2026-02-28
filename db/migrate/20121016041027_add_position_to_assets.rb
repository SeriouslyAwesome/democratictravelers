class AddPositionToAssets < ActiveRecord::Migration[4.2]
  def change
    add_column :assets, :position, :integer

    add_column :assets, :cover, :boolean

  end
end

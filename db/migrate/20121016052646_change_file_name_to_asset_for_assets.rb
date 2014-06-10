class ChangeFileNameToAssetForAssets < ActiveRecord::Migration
  def self.up
    rename_column :assets, :filename, :asset
    add_column :assets, :title, :string
    add_column :assets, :description, :text
    add_column :assets, :caption, :string
  end

  def self.down
    remove_column :assets, :caption
    remove_column :assets, :description
    remove_column :assets, :title
    rename_column :assets, :asset, :filename
  end
end
class AddPositionToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :position, :integer, null: false, default: 0
  end
end

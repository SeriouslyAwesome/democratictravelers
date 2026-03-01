class AddPositionToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :position, :integer, null: false, default: 0
  end
end

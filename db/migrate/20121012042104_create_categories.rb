class CreateCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :post_count

      t.timestamps
    end
  end
end

class AddSlugToCategories < ActiveRecord::Migration[4.2]
  def up
    add_column :categories, :slug, :string
    
    Category.reset_column_information
    Category.find_each(&:save)
  end
  
  def down
    remove_column :categories, :slug
  end
end

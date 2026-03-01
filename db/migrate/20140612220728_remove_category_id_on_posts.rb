class RemoveCategoryIdOnPosts < ActiveRecord::Migration[4.2]
  def change
    remove_column :posts, :category_id
  end
end

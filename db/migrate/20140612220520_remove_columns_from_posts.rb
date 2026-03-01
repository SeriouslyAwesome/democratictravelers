class RemoveColumnsFromPosts < ActiveRecord::Migration[4.2]
  def change
    remove_column :posts, :comment_count
    remove_column :posts, :attachment_count
    remove_column :posts, :format
  end
end

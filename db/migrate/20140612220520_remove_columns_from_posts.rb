class RemoveColumnsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :comment_count
    remove_column :posts, :attachment_count
    remove_column :posts, :format
  end
end

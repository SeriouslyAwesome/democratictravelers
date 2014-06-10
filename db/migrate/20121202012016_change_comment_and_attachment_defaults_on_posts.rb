class ChangeCommentAndAttachmentDefaultsOnPosts < ActiveRecord::Migration
  def self.up
    change_column_default :posts, :attachment_count, 0
    change_column_default :posts, :comment_count, 0
  end

  def self.down
    change_column_default :posts, :comment_count, "NULL"
    change_column_default :posts, :attachment_count, "NULL"
  end
end
class CleanupSchemaOnPosts < ActiveRecord::Migration
  def change
    change_column :posts, :title, :string, null: false
    change_column :posts, :slug, :string, null: false
    change_column :posts, :user_id, :integer, null: false, default: 1
  end
end

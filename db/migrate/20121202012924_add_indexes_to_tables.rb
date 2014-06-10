class AddIndexesToTables < ActiveRecord::Migration
  def self.up
    add_index :assets, [:assetable_id, :assetable_type]
    add_index :categories, :post_count
    add_index :category_connections, [:connectable_id, :connectable_type], :name => 'category_connection'
    add_index :category_connections, :category_id
    add_index :comments, [:commentable_id, :commentable_type], :name => 'comment_connection'
    add_index :comments, :user_id
    add_index :comments, :parent_id
    add_index :countries, :code
    add_index :posts, :user_id
    add_index :posts, :category_id
    add_index :users, :username
    
  end

  def self.down
    remove_index :units, :column => [:assetable_id, :assetable_type]
    remove_index :categories, :column => :post_count
    remove_index :category_connections, :column => [:connectable_id, :connectable_type]
    remove_index :category_connections, :column => :category_id
    remove_index :comments, :column => [:commentable_id, :commentable_type]
    remove_index :comments, :column => :user_id
    remove_index :comments, :column => :parent_id
    remove_index :countries, :column => :code
    remove_index :posts, :column => :user_id
    remove_index :posts, :column => :category_id
    remove_index :users, :column => :username
  end
end

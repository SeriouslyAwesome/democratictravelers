class AddIndexOnUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :email, :unique => false
  end
  
end

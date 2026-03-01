class AddIndexOnUsersEmail < ActiveRecord::Migration[4.2]
  def change
    add_index :users, :email, :unique => false
  end
  
end

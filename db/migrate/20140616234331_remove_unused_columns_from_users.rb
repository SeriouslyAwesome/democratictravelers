class RemoveUnusedColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :lat
    remove_column :users, :lng
    remove_column :users, :url
  end
end

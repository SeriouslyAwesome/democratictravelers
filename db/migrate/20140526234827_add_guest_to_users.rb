class AddGuestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :guest, :boolean, null: false, default: false
  end
end

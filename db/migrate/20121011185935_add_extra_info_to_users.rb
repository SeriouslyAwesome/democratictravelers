class AddExtraInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string

    add_column :users, :timezone, :integer

    add_column :users, :first_name, :string

    add_column :users, :last_name, :string

  end
end

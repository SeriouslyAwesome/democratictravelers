class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string

    add_column :users, :uid, :string

    add_column :users, :location, :string

    add_column :users, :lat, :float

    add_column :users, :lng, :float

    add_column :users, :url, :string

  end
end

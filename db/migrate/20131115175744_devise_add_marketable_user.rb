class DeviseAddMarketableUser < ActiveRecord::Migration
  def self.up
    add_column :users, :referring_url, :text
    add_column :users, :landing_url, :text
  end
  
  def self.down
    remove_column :users, :referring_url
    remove_column :users, :landing_url
  end
end
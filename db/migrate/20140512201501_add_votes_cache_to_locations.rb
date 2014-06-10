class AddVotesCacheToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :votes_cache, :integer, null: false, default: 0
    
    Location.reset_column_information
    Location.all.each do |location|
      location.update_attribute(:votes_cache, location.reputation_for(:votes))
    end
  end
end

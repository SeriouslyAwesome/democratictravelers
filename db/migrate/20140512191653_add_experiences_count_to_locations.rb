class AddExperiencesCountToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :experiences_count, :integer, default: 0
  end
  
  
end

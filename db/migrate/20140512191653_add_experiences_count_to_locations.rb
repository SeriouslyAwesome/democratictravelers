class AddExperiencesCountToLocations < ActiveRecord::Migration[4.2]
  def change
    add_column :locations, :experiences_count, :integer, default: 0
  end
  
  
end

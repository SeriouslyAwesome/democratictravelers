class AddIndexToExperiences < ActiveRecord::Migration
  def change
    add_index :experiences, :location_id
  end
end

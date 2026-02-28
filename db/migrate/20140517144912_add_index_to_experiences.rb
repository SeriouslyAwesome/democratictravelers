class AddIndexToExperiences < ActiveRecord::Migration[4.2]
  def change
    add_index :experiences, :location_id
  end
end

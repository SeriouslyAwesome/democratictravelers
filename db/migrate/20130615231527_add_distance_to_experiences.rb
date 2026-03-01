class AddDistanceToExperiences < ActiveRecord::Migration[4.2]
  def change
    add_column :experiences, :distance, :float
  end
end

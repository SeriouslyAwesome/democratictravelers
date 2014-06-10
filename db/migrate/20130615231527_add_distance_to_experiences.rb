class AddDistanceToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :distance, :float
  end
end

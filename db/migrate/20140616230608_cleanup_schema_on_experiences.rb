class CleanupSchemaOnExperiences < ActiveRecord::Migration
  def change
    change_column :experiences, :votes_cache, :integer, null: false, default: 0
    change_column :experiences, :location_id, :integer, null: false
    change_column :experiences, :name, :string, null: false
    remove_column :experiences, :starts, :datetime
    remove_column :experiences, :ends, :datetime
  end
end

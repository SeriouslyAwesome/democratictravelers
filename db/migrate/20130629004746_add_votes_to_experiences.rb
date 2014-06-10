class AddVotesToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :votes_cache, :integer
  end
end

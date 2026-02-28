class AddVotesToExperiences < ActiveRecord::Migration[4.2]
  def change
    add_column :experiences, :votes_cache, :integer
  end
end

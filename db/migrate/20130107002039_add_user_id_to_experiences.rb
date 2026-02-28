class AddUserIdToExperiences < ActiveRecord::Migration[4.2]
  def change
    add_column :experiences, :user_id, :integer
  end
end

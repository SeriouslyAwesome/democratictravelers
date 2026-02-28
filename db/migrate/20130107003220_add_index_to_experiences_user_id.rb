class AddIndexToExperiencesUserId < ActiveRecord::Migration[4.2]
  def change
    add_index :experiences, :user_id
  end
end

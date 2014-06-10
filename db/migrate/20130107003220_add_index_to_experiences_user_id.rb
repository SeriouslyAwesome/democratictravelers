class AddIndexToExperiencesUserId < ActiveRecord::Migration
  def change
    add_index :experiences, :user_id
  end
end

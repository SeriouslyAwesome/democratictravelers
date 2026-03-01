class AddIndexesToExperiencesPosts < ActiveRecord::Migration[4.2]
  def change
  	add_index :experiences_posts, :experience_id
  	add_index :experiences_posts, :post_id
  end
end

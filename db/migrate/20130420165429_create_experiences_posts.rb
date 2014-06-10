class CreateExperiencesPosts < ActiveRecord::Migration
  def change
    create_table :experiences_posts, id: false do |t|
      t.integer :experience_id
      t.integer :post_id
    end
  end
end

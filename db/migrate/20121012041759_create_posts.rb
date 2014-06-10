class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :user_id
      t.integer :category_id
      t.text :body
      t.string :subtitle
      t.datetime :published_at
      t.integer :comment_count
      t.integer :attachment_count
      t.string :format

      t.timestamps
    end
  end
end

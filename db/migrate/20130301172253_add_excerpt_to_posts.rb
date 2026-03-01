class AddExcerptToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :excerpt, :text
  end
end

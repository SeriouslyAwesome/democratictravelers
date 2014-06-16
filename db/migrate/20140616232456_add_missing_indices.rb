class AddMissingIndices < ActiveRecord::Migration
  def change
    add_index :experiences, :slug
    add_index :posts, [:published_at, :published]
  end
end

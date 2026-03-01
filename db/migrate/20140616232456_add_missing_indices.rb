class AddMissingIndices < ActiveRecord::Migration[4.2]
  def change
    add_index :experiences, :slug
    add_index :posts, [:published_at, :published]
  end
end

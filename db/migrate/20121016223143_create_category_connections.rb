class CreateCategoryConnections < ActiveRecord::Migration[4.2]
  def change
    create_table :category_connections do |t|
      
      t.integer :category_id
      t.references :connectable, :polymorphic => true

      t.timestamps
    end
  end
end

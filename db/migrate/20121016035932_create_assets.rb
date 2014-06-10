class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :type
    	t.string :filename
    	t.string :checksum
    	t.string :path
    	t.integer :filesize
    	t.integer :width
    	t.integer :height
    	t.integer :duration
    	t.integer :bit_rate

    	t.references :assetable, :polymorphic => true
    	t.timestamps
    end
  end
end

class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :long
      t.integer :venue_id
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.integer :state_id
      t.integer :zip
      t.text :description
      t.integer :country_id

      t.timestamps
    end
    add_index :locations, :venue_id
  end
end

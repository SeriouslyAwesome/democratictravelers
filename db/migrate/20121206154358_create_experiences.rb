class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :location_id
      t.string :name
      t.text :description
      t.datetime :starts
      t.datetime :ends

      t.timestamps
    end
  end
end

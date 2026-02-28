class AddIndexToLocationStates < ActiveRecord::Migration[4.2]
  def change
    add_index :locations, :state_id
  end
end

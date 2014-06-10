class AddIndexToLocationStates < ActiveRecord::Migration
  def change
    add_index :locations, :state_id
  end
end

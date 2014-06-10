class AddDoneToStates < ActiveRecord::Migration
  def change
    add_column :states, :done, :boolean
  end
end

class AddDoneToStates < ActiveRecord::Migration[4.2]
  def change
    add_column :states, :done, :boolean
  end
end

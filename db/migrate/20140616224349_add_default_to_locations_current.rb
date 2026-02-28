class AddDefaultToLocationsCurrent < ActiveRecord::Migration[4.2]
  def change
    change_column :locations, :current, :boolean, null: false, default: false
  end
end

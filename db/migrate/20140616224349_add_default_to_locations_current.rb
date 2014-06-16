class AddDefaultToLocationsCurrent < ActiveRecord::Migration
  def change
    change_column :locations, :current, :boolean, null: false, default: false
  end
end

class AddUuiDtoUsers < ActiveRecord::Migration
  def change
    add_column :users, :uuid, :string
  end
end

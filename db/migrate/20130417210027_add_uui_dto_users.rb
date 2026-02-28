class AddUuiDtoUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :uuid, :string
  end
end

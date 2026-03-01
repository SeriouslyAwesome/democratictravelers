class AddFormattedAddressToLocations < ActiveRecord::Migration[4.2]
  def change
    add_column :locations, :formatted_address, :string
  end
end

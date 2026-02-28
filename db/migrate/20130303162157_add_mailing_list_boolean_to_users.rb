class AddMailingListBooleanToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :mailing_list?, :boolean
  end
end

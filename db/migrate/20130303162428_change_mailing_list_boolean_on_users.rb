class ChangeMailingListBooleanOnUsers < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :mailing_list?, :mailing_list
  end
end

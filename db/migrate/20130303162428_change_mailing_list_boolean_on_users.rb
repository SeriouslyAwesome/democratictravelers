class ChangeMailingListBooleanOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :mailing_list?, :mailing_list
  end
end

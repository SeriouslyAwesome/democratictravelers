class AddStatusToExperiences < ActiveRecord::Migration[4.2]
  def change
    add_column :experiences, :status, :string
  end
end

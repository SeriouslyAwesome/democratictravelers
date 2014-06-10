class AddStatusToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :status, :string
  end
end

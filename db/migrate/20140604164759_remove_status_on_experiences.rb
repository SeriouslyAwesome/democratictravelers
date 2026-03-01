class RemoveStatusOnExperiences < ActiveRecord::Migration[4.2]
  def change
    remove_column :experiences, :status
  end
end

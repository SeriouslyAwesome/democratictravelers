class RemoveStatusOnExperiences < ActiveRecord::Migration
  def change
    remove_column :experiences, :status
  end
end

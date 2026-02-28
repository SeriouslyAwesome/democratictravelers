class AddSlugToExperiences < ActiveRecord::Migration[4.2]
  def change
    add_column :experiences, :slug, :string
  end
end

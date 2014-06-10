class AddSlugToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :slug, :string
  end
end

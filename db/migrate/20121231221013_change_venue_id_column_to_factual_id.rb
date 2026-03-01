class ChangeVenueIdColumnToFactualId < ActiveRecord::Migration[4.2]
  def change
    rename_column :locations, :venue_id, :factual_id
  end
end

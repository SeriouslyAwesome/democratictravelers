class ChangeVenueIdColumnToFactualId < ActiveRecord::Migration
  def change
    rename_column :locations, :venue_id, :factual_id
  end
end

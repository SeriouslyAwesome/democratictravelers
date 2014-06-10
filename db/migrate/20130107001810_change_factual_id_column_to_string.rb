class ChangeFactualIdColumnToString < ActiveRecord::Migration
  def change
    change_column :locations, :factual_id, :string
  end
end

class ChangeFactualIdColumnToString < ActiveRecord::Migration[4.2]
  def change
    change_column :locations, :factual_id, :string
  end
end

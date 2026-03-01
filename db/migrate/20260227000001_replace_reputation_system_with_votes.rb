class ReplaceReputationSystemWithVotes < ActiveRecord::Migration[4.2]
  def up
    create_table :votes do |t|
      t.references :user, index: true
      t.references :votable, polymorphic: true, index: true
      t.integer :value, null: false
      t.timestamps null: false
    end

    add_index :votes, [:user_id, :votable_id, :votable_type], unique: true, name: 'index_votes_on_user_and_votable'

    # Migrate data from rs_evaluations if the table exists
    if table_exists?(:rs_evaluations)
      execute <<-SQL
        INSERT INTO votes (user_id, votable_id, votable_type, value, created_at, updated_at)
        SELECT source_id, target_id, target_type, CAST(value AS integer), created_at, updated_at
        FROM rs_evaluations
      SQL
    end

    # Drop reputation system tables
    drop_table :rs_evaluations if table_exists?(:rs_evaluations)
    drop_table :rs_reputation_messages if table_exists?(:rs_reputation_messages)
    drop_table :rs_reputations if table_exists?(:rs_reputations)
  end

  def down
    drop_table :votes

    # Cannot restore reputation system tables — data migration is one-way
  end
end

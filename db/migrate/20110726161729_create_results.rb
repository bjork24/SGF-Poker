class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :placed
      t.boolean :money_back, :default => false
      t.integer :won, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end

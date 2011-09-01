class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.text :note
      t.datetime :date
      t.integer :location_id
      t.integer :wager
      t.integer :game_number
      t.boolean :ranked, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end

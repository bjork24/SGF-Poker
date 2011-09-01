class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :game_id
      t.integer :player_id
      t.string :text
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end

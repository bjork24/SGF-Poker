class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :name
      t.string :twitter
      t.string :avatar
      t.boolean :admin, :default => false
      t.boolean :active, :default => false
      t.string :provider
      t.string :uid
      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end

class CreateTweetTrackers < ActiveRecord::Migration
  def self.up
    create_table :tweet_trackers, :id => false do |t|
      t.string :tid
    end
    add_index(:tweet_trackers, :tid)
  end

  def self.down
    drop_table :tweet_trackers
    remove_index(:tweet_trackers, :tid)
  end
end

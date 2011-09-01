# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110901025914) do

  create_table "comments", :force => true do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.text     "note"
    t.datetime "date"
    t.integer  "location_id"
    t.integer  "wager"
    t.integer  "game_number"
    t.boolean  "ranked",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "twitter"
    t.string   "avatar"
    t.boolean  "admin",      :default => false
    t.boolean  "active",     :default => false
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "placed"
    t.boolean  "money_back", :default => false
    t.integer  "won",        :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweet_trackers", :id => false, :force => true do |t|
    t.string "tid"
  end

  add_index "tweet_trackers", ["tid"], :name => "index_tweet_trackers_on_tid"

end

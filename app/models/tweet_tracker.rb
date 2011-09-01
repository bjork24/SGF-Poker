class TweetTracker < ActiveRecord::Base
  
  def self.tweeted_before?(tid)
    TweetTracker.find_by_tid(tid.to_s) && true
  end
  
end




# == Schema Information
#
# Table name: tweet_trackers
#
#  tid :string(255)
#


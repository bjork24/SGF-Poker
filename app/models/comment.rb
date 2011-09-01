class Comment < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :game
  
  validates :text, :presence => true
  
  def self.recent
    Comment.find(:all, :order => "id desc", :limit => 5)
  end
  
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer(4)      not null, primary key
#  game_id    :integer(4)
#  player_id  :integer(4)
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#


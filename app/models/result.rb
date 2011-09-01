class Result < ActiveRecord::Base
  
  belongs_to :game
  belongs_to :player
  
end




# == Schema Information
#
# Table name: results
#
#  id         :integer(4)      not null, primary key
#  game_id    :integer(4)
#  player_id  :integer(4)
#  placed     :integer(4)
#  money_back :boolean(1)      default(FALSE)
#  won        :integer(4)      default(0)
#  created_at :datetime
#  updated_at :datetime
#


class Game < ActiveRecord::Base
  
  has_many :results, :dependent => :destroy
  has_many :players, :through => :results, :order => 'placed ASC'
  has_many :comments, :dependent => :destroy
  has_one :location
  belongs_to :location
  
  validates :wager, :presence => { :message => "You have to wager something!" }
  validates :player_ids, :presence => { :message => "I need some players!" }
  
  scope :for_year, lambda { |year| where("date >= ? and date <= ?", "#{year}0101", "#{year}1231").order('date DESC') }
  
  def self.years
    Game.ranked.select("date").map{ |item| item.date.year }.uniq.reverse
  end
  
  def self.ranked
    Game.where("ranked = true")
  end
  
end






# == Schema Information
#
# Table name: games
#
#  id          :integer(4)      not null, primary key
#  note        :text
#  date        :datetime
#  location_id :integer(4)
#  wager       :integer(4)
#  game_number :integer(4)
#  ranked      :boolean(1)      default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#


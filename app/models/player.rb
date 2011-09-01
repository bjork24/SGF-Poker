class Player < ActiveRecord::Base
  
  has_many :results
  has_many :games, :through => :results
  has_many :comments
  
  def self.create_with_omniauth(auth)
    create! do |player|
      player.provider = auth["provider"]
      player.uid = auth["uid"]
      player.name = auth["user_info"]["name"]
      player.twitter = auth["user_info"]["nickname"]
      player.avatar = auth["user_info"]["image"]
      if Player.count == 0
        player.admin = true 
        player.active = true 
      end
    end
  end
  
  def self.active
    Player.where("active = true")
  end
  
  def self.inactive
    Player.where("active = false")
  end
  
  def self.has_twitter
    Player.where("twitter IS NOT NULL")
  end
  
end



# == Schema Information
#
# Table name: players
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  twitter    :string(255)
#  avatar     :string(255)
#  admin      :boolean(1)      default(FALSE)
#  active     :boolean(1)      default(FALSE)
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#


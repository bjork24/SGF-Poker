class Location < ActiveRecord::Base
  
  belongs_to :game
  has_many :games
  
  validates :name, :presence => true
  
end

# == Schema Information
#
# Table name: locations
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#


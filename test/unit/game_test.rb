require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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


require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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


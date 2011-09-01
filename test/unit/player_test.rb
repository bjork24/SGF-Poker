require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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


require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'user email lowercase after validation' do
    user = User.new email: 'nEw@EpFl.Ch',
                    password: 'password'
    user.valid?

    assert_equal(user.email, 'new@epfl.ch')
  end
end

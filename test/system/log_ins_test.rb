require "application_system_test_case"

class LogInsTest < ApplicationSystemTestCase

  test 'sign up and creates a User' do
      visit(new_user_path)
      fill_in('Email', with: 'abogus@epfl.ch')
      click_on('Log in', match: :first)
      assert_equal 1, User.all.length
      assert_equal 'abogus@epfl.ch', User.first.email
  end

end

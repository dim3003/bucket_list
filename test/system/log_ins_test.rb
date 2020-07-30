require "application_system_test_case"

class LogInsTest < ApplicationSystemTestCase

  test 'sign up creates a User' do
      visit(new_user_path)
      fill_in('Email', with: 'abogus@epfl.ch')
      fill_in('Password', with: 'password')
      click_on('Sign In', match: :first)
      assert_equal 1, User.all.length
      assert_equal 'abogus@epfl.ch', User.first.email
  end

  test 'log in does not create a user' do
    user = User.new email: 'abogus@email.com',
                    password: 'password'
    user.save!
    visit(new_session_path)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log in', match: :first)
    assert_equal 1, User.all.length
  end

end

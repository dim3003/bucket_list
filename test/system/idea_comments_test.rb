require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase

  test 'adding a Comment to an Idea' do
    user = User.new email: 'an@email.com',
                    password: 'password'
    user.save!

    idea = Idea.new title: 'a valid idea',
                    user: User.new
    idea.save!

    visit(new_session_path)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log in', match: :first)

    visit(idea_path(idea))
    fill_in('Add a comment', with: 'a comment')
    click_on('Post', match: :first)

    assert_equal idea_path(idea), page.current_path
    assert page.has_content?('a comment')
  end

  test 'comments cannot be added when not logged in' do
    idea = Idea.new title: 'a valid idea',
                    user: User.new
    idea.save!

    visit(idea_path(idea))
    refute page.has_content?('Add a comment')
  end

end

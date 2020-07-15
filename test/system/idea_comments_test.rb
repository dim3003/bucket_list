require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase

  test 'adding a Comment to an Idea' do
    user = User.new email: 'an@email.com'
    user.save!

    idea = Idea.new title: 'a valid idea'
    idea.save!

    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    
    visit(idea_path(idea))
    fill_in('Add a comment', with: 'a comment')
    sleep(3.seconds)
    click_on('Post', match: :first)

    sleep (5.seconds)
    assert_equal idea_path(idea), page.current_path
    assert page.has_content?('a comment')
  end

end

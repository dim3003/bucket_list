require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase

  test 'adding a Comment to an Idea' do
    idea = Idea.new title: 'a valid idea'
    idea.save!
    visit(idea_path(idea))
    fill_in('Add a comment', with: 'a comment')
    click_on('Post', match: :first)

    assert_equal page.current_path, idea_path(idea)
    assert page.has_content?('a comment')
  end

end

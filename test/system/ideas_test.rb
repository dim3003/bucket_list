require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'create new idea' do
    visit('/ideas/new')
    fill_in('title', with: 'Test Idea')
    fill_in('done_count', with: 420)
    fill_in('photo_url', with: 'https://www.gettyimages.co.uk/gi-resources/images/RoyaltyFree/Apr17Update/ColourSurge1.jpg')
    click_on('Create idea', match: :first)
    assert page.has_content?('Test Idea')
  end

  test 'index loads ideas' do
    idea_1 = Idea.new
    idea_1.title = 'Join a tennis club'
    idea_1.save!

    idea_2 = Idea.new
    idea_2.title = 'Start a blog'
    idea_2.save!

    visit('/ideas/index')
    assert page.has_content?('Join a tennis club')
    assert page.has_content?('Start a blog')
  end
end

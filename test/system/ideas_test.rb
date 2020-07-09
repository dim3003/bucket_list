require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'create new idea' do
    visit('/ideas/new')
    sleep(4.seconds)
    fill_in('title', with: 'Test Idea')
    fill_in('done_count', with: '420')
    fill_in('photo_url', with: 'https://www.gettyimages.co.uk/gi-resources/images/RoyaltyFree/Apr17Update/ColourSurge1.jpg')
    sleep(4.seconds)
  end
end

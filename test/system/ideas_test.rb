require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'create new idea' do
    visit(new_idea_path)
    fill_in('Title', with: 'Test Idea')
    fill_in('Done count', with: 420)
    fill_in('Photo url', with: 'https://www.gettyimages.co.uk/gi-resources/images/RoyaltyFree/Apr17Update/ColourSurge1.jpg')
    click_on('Create Idea', match: :first)
    assert page.has_content?('Test Idea')
  end

  test 'index loads ideas' do
    idea_1 = Idea.new
    idea_1.title = 'Join a tennis club'
    idea_1.save!

    idea_2 = Idea.new
    idea_2.title = 'Start a blog'
    idea_2.save!

    visit(ideas_path)
    assert page.has_content?('Join a tennis club')
    assert page.has_content?('Start a blog')
  end

  test 'edit idea test' do
    idea = Idea.new
    idea.title = 'edit idea test'
    idea.save!
    visit(edit_idea_path(idea))
    fill_in('Title', with: 'Climb Bishorn')
    fill_in('Done count', with: 69)
    click_on('Update', match: :first)
    click_on('Climb Bishorn', match: :first)
    assert page.has_content?('Climb Bishorn')
    assert page.has_content?('69 have done this')
  end

  test 'search' do
    idea_1 = Idea.new
    idea_1.title = 'Climb Mont Blanc'
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Visit Niagara Falls'
    idea_2.save!

    visit('/')
    fill_in('q', with: 'Mont')
    click_on('Search', match: :first)

    assert current_path.include?(ideas_path)
    assert page.has_content?('Climb Mont Blanc')
    refute page.has_content?('Visit Niagara Falls')
  end

  test 'search no idea found' do
    visit(ideas_path)
    assert page.has_content?('No idea found')
  end

  test 'check homepage ideas' do
    4.times do |i|
      idea = Idea.new
      idea.title = "Exciting new idea #{i+1}"
      idea.save!
    end

    visit('/')

    assert page.has_content?('Exciting new idea 2')
    assert page.has_content?('Exciting new idea 3')
    assert page.has_content?('Exciting new idea 4')

    refute page.has_content?('Exciting new idea 1')
  end

  test 'search description test' do
    idea_1 = Idea.new
    idea_1.title = 'Go cycling across Europe'
    idea_1.description = 'An amazing way to see lots of Europe'
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Visit Provence'
    idea_2.description = 'Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender'
    idea_2.save!
    idea_3 = Idea.new
    idea_3.title = 'Overnight hike in Switzerland'
    idea_3.description = 'Stay in a Swiss refuge in the mountains'
    idea_3.save!

    visit('/')
    fill_in('q', with: 'cycling')
    click_on('Search', match: :first)

    assert page.has_content?('cycling across Europe')
    assert page.has_content?('Visit Provence')
    refute page.has_content?('Overnight hike in Switzerland')
  end

  test 'validation test for creating ideas' do
    visit(new_idea_path)
    fill_in('Title', with: 'Test Idea that is too long to be able to be validated reeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee')
    fill_in('Done count', with: 420)
    fill_in('Photo url', with: 'https://www.gettyimages.co.uk/gi-resources/images/RoyaltyFree/Apr17Update/ColourSurge1.jpg')
    click_on('Create Idea', match: :first)

    assert page.has_content?('Title is too long (maximum is 75 characters)')
  end

  test 'validation test for editing ideas' do
    idea = Idea.new title: 'Test Idea'
    idea.save

    visit(edit_idea_path(idea))
    fill_in('Title', with: '')
    click_on('Update Idea', match: :first)

    assert page.has_content?("Title can't be blank")
  end
end

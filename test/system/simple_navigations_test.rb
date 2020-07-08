require "application_system_test_case"

class SimpleNavigationsTest < ApplicationSystemTestCase
  test 'search term is displayed' do
    visit('/')
    assert page.has_content?('Bucket List')
    fill_in('q', with: 'Spain').send_keys(:enter)
    assert has_content?('Spain')
    assert current_url.include?('q=Spain')
  end

  test 'style guide navigation' do
    visit('/')
    sleep(3.seconds)
    click_on('Style Guide', match: :first)
    sleep(3.seconds)
    assert page.has_content?('Atoms')
    assert page.has_content?('Molecules')
    assert page.has_content?('Organisms')
    sleep(3.seconds)
    click_on('Molecules', match: :first)
    assert page.has_content?('Card')
    sleep(3.seconds)
    click_on('Organisms', match: :first)
    assert page.has_content?('Create Goal')
    sleep(3.seconds)
    click_on('My Bucket List', match: :first)
    assert page.has_content?('Some ideas')
  end
end

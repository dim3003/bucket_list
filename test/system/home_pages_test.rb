require "application_system_test_case"

class HomePagesTest < ApplicationSystemTestCase
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
  end
end

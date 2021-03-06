require "application_system_test_case"

class ShowIdeasTest < ApplicationSystemTestCase
  test 'show' do
    idea = Idea.new title: 'Ragnar Lothbrok',
                    user: User.new
    idea.done_count = 789
    idea.save!

    visit(idea_path(idea))
    assert page.has_content?('Ragnar Lothbrok')
    assert page.has_content?('789 have done')
    assert page.has_content?(idea.created_at.strftime("%d %b '%y"))

    click_on('Edit', match: :first)

    assert_equal current_path, edit_idea_path(idea)
  end
end

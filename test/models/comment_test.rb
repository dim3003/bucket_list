require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'changing the associated Idea for a Comment' do
    idea = Idea.new title: 'a valid title'
    idea.save
    comment = Comment.new(body: "I'd like to do this!", idea: idea)
    idea_2 = Idea.new title: 'another valid title'
    idea_2.save
    comment.idea = idea_2
    comment.save

    assert_equal Comment.first.idea, idea_2

  end

end

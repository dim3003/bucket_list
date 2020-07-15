require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'changing the associated Idea for a Comment' do
    idea = Idea.new title: 'a valid title',
                    user: User.new
    idea.save
    comment = Comment.new body: "I'd like to do this!", idea: idea, user: User.new
    idea_2 = Idea.new title: 'another valid title',
                      user: User.new
    idea_2.save!
    comment.idea = idea_2
    comment.save!

    assert_equal Comment.first.idea, idea_2
  end

  test 'cascading save' do
    idea = Idea.new title: 'a valid title',
                    user: User.new
    idea.save
    comment = Comment.new body: "Great idea!", user: User.new
    idea.comments << comment
    idea.save
    assert_equal Comment.first, comment
  end

  test 'Comments are ordered properly' do
    idea = Idea.new title: 'a valid title',
                    user: User.new
    idea.save

    comment = Comment.new body: "This would be great fun", user: User.new
    comment_2 = Comment.new body: "I agree! I's like to do this as well", user: User.new

    idea.comments << comment
    idea.comments << comment_2
    idea.save

    assert_equal Comment.first, comment
    assert_equal 2, idea.comments.length
  end

end

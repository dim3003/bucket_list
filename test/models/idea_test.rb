require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'the first empty Idea created is first in the list' do
    first_idea = Idea.new
    first_idea.save!
    second_idea = Idea.new
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'the first complete Idea created is first in the list' do
    first_idea = Idea.new
    first_idea.title = 'Cycle the length of the United Kingdom'
    first_idea.photo_url = 'http://mybucketlist.ch/an_image.jpg'
    first_idea.done_count = 12
    first_idea.save!
    second_idea = Idea.new
    second_idea.title = 'Visit Japan'
    second_idea.photo_url = 'http://mybucketlist.ch/second_image.jpg'
    second_idea.done_count = 3
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'updated_at is changed after updating title' do
    idea = Idea.new
    idea.title = 'Visit Marrakech'
    idea.save!
    first_updated_at = idea.updated_at
    idea.title = 'Visit the market in Marrakech'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating done_count' do
    idea = Idea.new
    idea.done_count = 42
    idea.save!
    first_updated_at = idea.updated_at
    idea.done_count = 43
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url' do
    idea = Idea.new
    idea.photo_url = 'https://images.unsplash.com/photo-1516632664305-eda5d6a5bb99?ixlib=rb-1.2.1&w=1000&q=80'
    idea.save!
    first_updated_at = idea.updated_at
    idea.photo_url = 'http://data.freehdw.com/bunny-rabbit-cute-free-desktop.jpg'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'search' do
    idea = Idea.new
    idea.title = 'Stand at the top of the Empire State Building'
    idea.save!
    assert_equal Idea.search('the top').length, 1
  end

  test 'search no matching' do
    idea = Idea.new
    idea.title = 'Stand at the top of the Empire State Building'
    idea.save!
    assert_empty Idea.search('snorkelling')
  end

  test 'search two matching' do
    idea_1 = Idea.new
    idea_1.title = 'Stand at the top of the Empire State Building'
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Stand on the pyramids'
    idea_2.save!
    assert_equal Idea.search('Stand').length, 2
  end

  test 'most_recent no idea' do
    assert_empty Idea.most_recent
  end

  test 'most_recent 2 ideas' do
    idea_1 = Idea.new
    idea_1.title = 'Stand at the top of the Empire State Building'
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Stand on the pyramids'
    idea_2.save!

    assert_equal Idea.most_recent.length, 2
    assert_equal Idea.most_recent.first, idea_2
  end

  test 'most_recent 6 ideas' do
    idea_1 = Idea.new
    idea_1.title = 'Stand at the top of the Empire State Building'
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Stand on the pyramids'
    idea_2.save!
    idea_3 = Idea.new
    idea_3.title = 'Stand at the top of the Empire State'
    idea_3.save!
    idea_4 = Idea.new
    idea_4.title = 'Stand on the'
    idea_4.save!
    idea_5 = Idea.new
    idea_5.title = 'Stand at the top of the Empire'
    idea_5.save!
    idea_6 = Idea.new
    idea_6.title = 'Stand on'
    idea_6.save!

    assert_equal Idea.most_recent.length, 3
    assert_equal Idea.most_recent.first, idea_6
  end


end

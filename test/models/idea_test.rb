require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'the first empty Idea created is first in the list' do
    first_idea = Idea.new title: 'first_idea',
                          user: User.new
    first_idea.save!
    second_idea = Idea.new title: 'Second_idea',
                           user: User.new
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'the first complete Idea created is first in the list' do
    first_idea = Idea.new title: 'Cycle the length of the United Kingdom',
                          photo_url: 'http://mybucketlist.ch/an_image.jpg',
                          done_count: 12,
                          user: User.new
    first_idea.save!
    second_idea = Idea.new title: 'Visit Japan',
                           photo_url: 'http://mybucketlist.ch/second_image.jpg',
                           done_count: 3,
                           user: User.new
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'updated_at is changed after updating title' do
    idea = Idea.new title: 'Visit Marrakech',
                    user: User.new
    idea.save!
    first_updated_at = idea.updated_at
    idea.title = 'Visit the market in Marrakech'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating done_count' do
    idea = Idea.new title: 'updated at test',
                    user: User.new
    idea.done_count = 42
    idea.save!
    first_updated_at = idea.updated_at
    idea.done_count = 43
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url' do
    idea = Idea.new title: 'updated_at idea',
                    photo_url: 'https://images.unsplash.com/photo-1516632664305-eda5d6a5bb99?ixlib=rb-1.2.1&w=1000&q=80',
                    user: User.new
    idea.save!
    first_updated_at = idea.updated_at
    idea.photo_url = 'http://data.freehdw.com/bunny-rabbit-cute-free-desktop.jpg'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'search' do
    idea = Idea.new title:'Stand at the top of the Empire State Building',
                    user: User.new
    idea.save!
    assert_equal Idea.search('the top').length, 1
  end

  test 'search no matching' do
    idea = Idea.new title: 'Stand at the top of the Empire State Building',
                    user: User.new
    idea.save!
    assert_empty Idea.search('snorkelling')
  end

  test 'search two matching' do
    idea_1 = Idea.new title: 'Stand at the top of the Empire State Building',
                      user: User.new
    idea_1.save!
    idea_2 = Idea.new title: 'Stand on the pyramids',
                      user: User.new
    idea_2.save!
    assert_equal Idea.search('Stand').length, 2
  end

  test 'most_recent no idea' do
    assert_empty Idea.most_recent
  end

  test 'most_recent 2 ideas' do
    idea_1 = Idea.new title: 'Stand at the top of the Empire State Building',
                      user: User.new
    idea_1.save!
    idea_2 = Idea.new title: 'Stand on the pyramids',
                      user: User.new
    idea_2.save!

    assert_equal Idea.most_recent.length, 2
    assert_equal Idea.most_recent.first, idea_2
  end

  test 'most_recent 6 ideas' do
    ideas = Array.new
    6.times do |i|
      idea = Idea.new title: "Exciting new idea #{i+1}",
                      user: User.new
      idea.save!
      ideas.push(idea)
    end
    assert_equal Idea.most_recent.length, 3
    assert_equal Idea.most_recent.first, ideas[5]
  end

  test 'search with tag' do
    idea = Idea.new title: 'Surfing in Portugal',
                    user: User.new,
                    tag: 'Sike!'
    idea.save!

    assert_equal Idea.search('coast').length, 1
  end

  test 'search with description and title' do
    idea_1 = Idea.new title: 'Overnight hike in Switzerland',
                      tag: 'Stay',
                      user: User.new
    idea_1.save!
    idea_2 = Idea.new title: 'Hike the mountains in Italy',
                      tag: 'See',
                      user: User.new
    idea_2.save!

    assert_equal Idea.search('mountains').length, 2
  end

  test 'title validation' do
    idea = Idea.new title: 'A title too long which should not pass the validation test we put in place !',
                    user: User.new
    refute idea.valid?
  end

  test 'title validation with no title attribute' do
    idea = Idea.new user: User.new
    refute idea.valid?
  end

end

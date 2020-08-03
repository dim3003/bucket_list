require 'test_helper'

class RolesHelperTest < ActionView::TestCase
  attr_accessor :current_user

  test 'registered users can edit owned ideas' do
    user = User.create(email: 'owner@epfl.ch', password: 'password')
    self.current_user = user

    idea = Idea.create(title: 'A test idea!', user: user)

    assert can_edit?(idea)
  end

  test 'admin user can edit not owned ideas' do
    user = User.create(email: 'admin@epfl.ch', password: 'password', role: 'admin')
    self.current_user = user

    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    idea = Idea.create(title: 'A test idea!', user: owner)

    assert can_edit?(idea)
  end

  test 'registered users can not edit not owned ideas' do
    user = User.create(email: 'owner@epfl.ch', password: 'password')
    self.current_user = user

    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    idea = Idea.create(title: 'A test idea!', user: owner)

    refute can_edit?(idea)
  end

end

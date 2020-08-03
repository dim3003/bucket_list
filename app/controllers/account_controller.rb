class AccountController < ApplicationController
  before_action :ensure_authenticated
  
  current_user :helper_method

  def ideas
    user_id = session[:user_id]
    user = User.find(user_id)
    @ideas = user.ideas
  end

  def ensure_authenticated
    unless(logged_in?)
      redirect_to login_path
    end
  end

  def current_user
    User.find(session[:user_id])
  end
end

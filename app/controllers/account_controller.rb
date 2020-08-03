class AccountController < ApplicationController
  before_action :ensure_authenticated

  helper_method :current_user


  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to account_path
  end

  def ideas
    user_id = session[:user_id]
    user = User.find(user_id)
    @ideas = user.ideas
  end

  def goals
    @goals = current_user.goals
  end


  def ensure_authenticated
    unless(logged_in?)
      redirect_to login_path
    end
  end

  def current_user
    User.find(session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar_url)
  end
end

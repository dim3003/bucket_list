class AccountController < ApplicationController
  before_action :ensure_authenticated, only: :edit
  before_action :ensure_owner, only: :edit

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

  def ensure_owner
    idea = Idea.find(params[:id])

    if(idea.user == current_user)
      return
    end

    redirect_to(account_path)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :avatar_url)
  end
end

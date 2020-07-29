class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create_by(user_params)
    if(@user.save)
      session[:user_id] = @user.id
    else
      render 'new'
    end
    redirect_to ideas_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end

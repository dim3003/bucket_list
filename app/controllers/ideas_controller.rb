class IdeasController < ApplicationController
  include RolesHelper

  before_action :ensure_authenticated,           only: [:new, :create, :edit, :update]
  before_action :load_idea,                      only: [:edit, :update, :destroy]
  before_action :authorize_to_edit_idea,         only: [:edit, :update, :destroy]

  def index
    @search_term = params[:q]
    logger.info("Search completed using #{@search_term}")

    @ideas = Idea.search(@search_term).page(params[:page])
  end

  def new
    @idea = Idea.new
  end

  def show
    @idea = Idea.find(params[:id])
    @comment = Comment.new
    @display_add_comment = session[:user_id].present?
    if(logged_in?)
      @disable_add_goal = current_user.goals.exists?(@idea.id)
    end
  end

  def create
    user = User.find(session[:user_id])
    @idea = Idea.new(idea_resource_params)
    @idea.user = user
    if(@idea.save)
      redirect_to ideas_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if(@idea.update(idea_resource_params))
      redirect_to account_ideas_path
    else
      render 'edit'
    end
  end

  def destroy
    @idea.destroy!
  end

  private

  def idea_resource_params
    params.require(:idea).permit(:title, :description, :photo_url, :done_count, :description)
  end

  def load_idea
    @idea = Idea.find(params[:id])
  end

  def authorize_to_edit_idea
    redirect_to(account_path) unless (can_edit?(@idea))
  end

end

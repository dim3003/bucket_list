class PhotosController < ApplicationController
  include RolesHelper

  before_action :ensure_authenticated
  before_action :load_idea
  before_action :authorize

  def index
    @photo = Unsplash::Photo.random(query: @idea.title)
  end

  def create
  end

  private

  def load_idea
    @idea = Idea.find(params[:idea_id])
  end

  def authorize
    redirect_to(account_path) unless (can_edit?(@idea))
  end

end

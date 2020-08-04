class CommentsController < ApplicationController
  before_action :ensure_authenticated

  def create
    @comment = Comment.new(comment_resource_params)
    idea = Idea.find(params[:idea_id])
    @comment.idea = idea
    @comment.user = current_user
    @comment.save
  end

  private

  def comment_resource_params
    params.require(:comment).permit(:body)
  end

end

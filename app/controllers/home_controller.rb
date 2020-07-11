class HomeController < ApplicationController
  def index
    @ideas = Idea.all.most_recent
  end
end

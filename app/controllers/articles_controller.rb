class ArticlesController < ApplicationController
  def index
    @articles = current_user.articles
  end

  def show
  end
end

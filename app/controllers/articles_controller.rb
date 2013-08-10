class ArticlesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles
  end

  def show
    @article = Article.find(params[:id])
  end
end

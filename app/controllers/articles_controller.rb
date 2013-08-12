class ArticlesController < ApplicationController
  before_action :signed_in_user, only: [:new]

  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles
  end

  def new
    
  end

  def show
    @article = Article.find(params[:id])
  end
end

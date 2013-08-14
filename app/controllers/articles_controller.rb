class ArticlesController < ApplicationController
  before_action :signed_in_user, only: [:new]

  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    # @user = current_user  # which is better?
    @article = Article.new
  end

  def create
    @user = User.find(params[:user_id])
    @article = @user.articles.build(user_params)
    if @article.save
      flash[:success] = "\"#{@article.title}\" has been published."
      redirect_to @article
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:article).permit(:title, :content)
    end
end

class ArticlesController < ApplicationController
  before_action :signed_in_user, except: [:index, :show]
  before_action :correct_user, only: [:new, :create]
  before_action :correct_article, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = @user.articles.build(article_params)
    if @article.save
      flash[:success] = "\"#{@article.title}\" has been published."
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      flash[:success] = "#{@article.title} updated."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    def article_params
      params.require(:article).permit(:title, :content)
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def correct_article
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to(root_path) if @article.nil?
    end
end

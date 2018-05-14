class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :same_user, except: [:index, :show, :new, :create]
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  def new
    if !logged_in?
      flash[:danger] = "You must login to post an article"
      redirect_to login_path
    end
    @article = Article.new
  end
  def edit
  end
  def update
    if @article.update article_params
      flash[:success] = "Article sucessfully updated."
      redirect_to article_path
    else
      render 'edit'
    end
  end
  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user;
    if @article.save
      flash[:success] = "Article was sucessfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  def destroy
    @article.destroy
    flash[:danger] = "sucessfully deleted"
    redirect_to articles_path
  end

  def show
  end
  def same_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform edit actions"
      redirect_to login_path
    elsif current_user != @article.user
      flash[:danger] = "you can edit only your articles"
      redirect_to user_path(current_user)
    end
  end
  private
  def article_params
    params.require(:article).permit(:title, :description)
  end
  def set_article
    @article = Article.find(params[:id])
  end
end

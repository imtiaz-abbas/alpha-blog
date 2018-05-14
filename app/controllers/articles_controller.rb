class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  def new
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
    @article.user = User.last;
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

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end
  def set_article
    @article = Article.find(params[:id])
  end
end

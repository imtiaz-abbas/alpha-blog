class UsersController < ApplicationController
  before_action :get_user, only: [:show, :update, :edit, :destroy]
  before_action :same_user , only: [:edit, :destroy, :update]
  def destroy
    session[:user_id] = nil
    User.destroy(@user.id)

    redirect_to signup_path
  end
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  def new
    @user = User.new
  end
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  def edit
  end
  def update
    if @user.update user_params
      flash[:success] = "sucessfully updated."
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  def create
    # debugger
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'welcome to alpha blog'
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render 'new'
    end
  end
  def get_user
      @user = User.find(params[:id])
  end
  def same_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action"
      redirect_to login_path
    elsif (current_user != @user)
      flash[:danger] = "You don't have permissions to perform this action"
      redirect_to login_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end

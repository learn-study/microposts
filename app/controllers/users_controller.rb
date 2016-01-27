class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers, :favorites]
  before_action :authentication, only: [:edit, :update]
  before_action :logged_in_user, only: [:index]
  
  def index
    @user = current_user
    @users = User.all.where.not(:id => @user.id).page params[:page]
    render 'show'
  end

  def show
    @microposts = @user.microposts.order(created_at: :desc).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to new_session_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "update your profile!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def followings
    @followings = @user.following_users.page params[:page]
    render 'show'
  end

  def followers
    @followers = @user.follower_users.page params[:page]
    render 'show'
  end

  def favorites
    @favorites = @user.favorite_microposts.order(created_at: :desc).page params[:page]
    render 'show'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def authentication
    redirect_to root_url unless current_user == @user
  end

  def logged_in_user
    redirect_to root_url unless logged_in?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :area, :url,
                                 :password_confirmation, :age, :gender, :profile)
  end
end

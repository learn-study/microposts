class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authentication, only: [:edit, :update]
  before_action :logged_in_user, only: [:index]
  
  def index
    @user = current_user
    @users = User.all
  end

  def show
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

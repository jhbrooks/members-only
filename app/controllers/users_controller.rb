class UsersController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @users = User.order(created_at: :desc).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the club!"
      redirect_to posts_path
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      redirect_to posts_path
    else
      flash.now[:danger] = "Invalid name/password combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to posts_path
  end
end

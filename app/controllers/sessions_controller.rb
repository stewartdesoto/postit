class SessionsController < ApplicationController
  # get /login form
  def new

  end

  # post /login form
  def create
    @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
      flash[:success]="You are now logged in"
      session[:user_id]=@user.slug
      redirect_to root_url
    else
      flash[:notice]="Error in logging in"
      render 'new'
    end
  end

  # get /logout form
  def destroy
    session[:user_id]=nil
    flash[:notice]="You have been logged out"
    redirect_to root_url
  end
end
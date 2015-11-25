class UsersController < ApplicationController

before_action :set_user, only: [:show, :edit, :update]

  def show
    @posts=@user.posts
    @comments=@user.comments
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      flash[:success]="You successfully registered"
      session[:user_id]=@user.slug
      redirect_to root_url
    else
      flash[:notice]="Errors in registering"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success]="You updated your profile"
      redirect_to root_url
    else
      flash[:notice]="Errors in updating profile"
      render 'edit'
    end
  end


  private
    def user_params
      params.require(:user).permit(:username, :password)
    end

    def set_user
      @user = User.find_by(slug: params[:id])
    end

end
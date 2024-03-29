class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def current_user
    User.find_by(slug: session[:user_id]) if session[:user_id]
  end


  def logged_in?
    !!current_user
  end

  def require_user
    redirect_to root_url unless logged_in?
  end

end

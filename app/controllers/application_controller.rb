class ApplicationController < ActionController::Base
  
  # make available to application helper as well, to use in views
  helper_method :current_user, :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user # current_user as boolean
  end

  def require_user
    if !logged_in?
      flash[:alert] = "Must be logged in"
      redirect_to login_path
    end
  end
end

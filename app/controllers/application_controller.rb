class ApplicationController < ActionController::Base
  
  # make available to application helper as well, to use in views
  helper_method :current_user, :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user # current_user as boolea
  end

end

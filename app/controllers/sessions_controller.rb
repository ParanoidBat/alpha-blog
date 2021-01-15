class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      
      flash[:notice] = "Logged In"
      redirect_to user
      
    else
      flash.now[:alert] = "Invalid Credentials"
      render 'new'
    end
  end
  
  def destroy
    if session[:user_id]
      session[:user_id] = nil
      flash[:notice] = "Logged Out"
    end

    redirect_to root_path
  end
end

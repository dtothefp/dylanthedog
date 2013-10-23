class SessionsController < ApplicationController

  def new
    unless logged_in? == false
      user = User.find(session[:user_id])
      redirect_to user_path(user)
    end
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_user_path
  end

end
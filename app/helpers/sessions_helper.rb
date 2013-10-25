module SessionsHelper

  def logged_in?
   session[:user_id].present?
  end

  def authenticated!
    unless logged_in?
      redirect_to new_session_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorized!
    unless @user.id == session[:user_id]
      redirect_to user_path(session[:user_id])
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

end
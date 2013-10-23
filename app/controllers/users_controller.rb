class UsersController < ApplicationController

  before_action :authenticated!, :set_user, :authorized!, except: [:new, :create]
  
  def new
   @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      #set session for new user signed up
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    logger.info "SHOW??????????????"
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy 
      redirect_to new_user_path
    else
      render :edit
    end
  end

  private 

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
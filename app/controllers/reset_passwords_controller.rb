class ResetPasswordsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by(params[:email])
    @user.reset_password_token!
    send_reset_password_email(@user)
  end

  def edit
    @user = User.find_by(reset_password_token: params[:reset_password_token])
    render :edit
  end

  def update
    @user = User.find_by(email: params[:user][:email])
    if @user
      @user.update(user_params)
      @user.reset_password_token!
      sign_in!(@user)
      flash[:errors] = ["Password updated"]
      redirect_to users_url
    else
      flash[:errors] = ["Can't find user"]
      redirect_to new_session_url
    end
  end

  private

  def reset_password
    #WE ARE LETTING THE USER RESET THEIR PASSWORD BY RESETTING THE SESSION TOKEN AND SENDING THAT TO THEM IN AN EMAIL
    @user = User.find_by(session_token: params[:token]) # :token is from db
    if params[:token] && @user
      redirect_to new_password_url
    else
      raise ActiveRecord::RecordNotFound.new()
    end
  end

  def send_reset_password_email(user)
    UserMailer.reset_password(user).deliver!
    flash[:errors] = ["Check your email"]
    redirect_to new_sessions_url
  end

  def user_params
    params.require(:user).permit(:password)
  end

end

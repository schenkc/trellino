class SessionsController < ApplicationController
  before_action :require_signed_in, only: [:destroy]
  before_action :require_signed_out, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if @user
      sign_in!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = ["Learn to type! Otra vez!"]
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to new_session_url
  end

end
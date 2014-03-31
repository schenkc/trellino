class FriendCirclesController < ApplicationController

  def new
    @user = current_user
    render :new
  end

  def create
    @friend_circle = FriendCircle.new(circle_params)
    @friend_circle.owner_id = current_user.id
    @friend_circle.member_ids = member_id_params

    if @friend_circle.save
      flash[:errors] = ["Friend circle created. Members added."]
      redirect_to user_url(current_user)
    else
      flash[:errors] = @friend_circle.errors.full_messages
      render :new
    end
  end

  def index
  end

  private

  def circle_params
    params.require(:friend_circle).permit(:name)
  end

  def member_id_params
    params[:user][:id]
  end

end
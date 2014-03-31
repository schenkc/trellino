class FriendCircleController < ApplicationController

  def new
    @user = current_user
    render :new
  end

  def create
    @friend_circle = FriendCircle.new(circle_params)

    if @friend_circle.save

      redirect_to
    else

    end
  end

  private

  def circle_params
    params.require(:friend_circle).permit(:name, :owner_id)
  end

end
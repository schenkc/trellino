class FriendCirclesController < ApplicationController

  def new
    @circle = FriendCircle.new
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
    @circles = current_user.owned_circles
  end

  def show
    @circle = current_user.owned_circles.find(params[:id])
  end

  def edit
    @circle = current_user.owned_circles.find(params[:id])
  end

  def update
    @circle = current_user.owned_circles.find(params[:id])
    if @circle.update_attributes(circle_params)
      redirect_to @circle
    else
      flash.now[:errors] = @circle.errors.full_messages
      render :edit
    end
  end



  private

  def circle_params
    params.require(:friend_circle).permit(:name, :owner_id, member_ids: [])
  end

  def member_id_params
    params[:friend_circle][:member_ids]
  end

end
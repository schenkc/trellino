class PostsController < ApplicationController

  def new
    @post = current_user.posts.new
    3.times { @post.links.new }
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.links.new(link_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def index
    @posts = Post.all
  end

  def feed
    fail
    @posts = current_user.friend_posts
  end

  def post_params
    params.require(:post).permit(:user_id, :body, :circle_ids)
  end

  def link_params
    params.permit(link: [:body, :url, :destroy, :id])
          .require(:link)
          .values
          .reject do |ln|
            ln[:body].blank? && ln[:url].blank?
          end
  end
end

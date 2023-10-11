class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @author = User.find(@post.author_id)
    @new_post = current_user.posts.build if user_signed_in?
  end

  def new
    @user = User.find(params[:user_id]) 
    @post = @user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    if params[:id] == 'sign_out'
      sign_out current_user
      redirect_to root_path and return
    end

    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments)
  end

  def destroy
    @user = User.find(params[:id])
    @user.posts.each do |post|
      post.comments.destroy_all
      post.likes.destroy_all
    end
    @user.posts.destroy_all
    @user.destroy
    redirect_to users_path
  end
end

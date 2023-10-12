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
end

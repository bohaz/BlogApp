class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_or_initialize_by(author: current_user)

    if @like.persisted?
      @like.destroy
      notice_message = 'You disliked the post!'
    else
      @like.save
      notice_message = 'You liked the post!'
    end

    redirect_to user_post_path(@post.author, @post), notice: notice_message
  end
end

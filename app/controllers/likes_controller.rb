class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(author: current_user)
    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'You liked the post!'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Error liking the post.'
    end
  end
end

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully added.'
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
      redirect_to user_post_path(@post.author, @post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

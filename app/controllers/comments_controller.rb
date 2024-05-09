class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully added.'
    else
      flash[:alert] = 'Comment cannot be blank.'
      redirect_to user_post_path(@post.author, @post)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

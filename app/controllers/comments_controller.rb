class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(author: current_user))
    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully added.'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Error adding comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

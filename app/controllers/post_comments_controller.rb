class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.build(post_comment_params)
    @comment.user_id = current_user.id
    @comment.save
    if @comment.save
      render :index
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end

  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment,:content, :post_id, :user_id)
  end
end
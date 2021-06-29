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
    @comment = PostComment.find(params[:id])
    if @comment.destroy
      #render :index
    end
  end

  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment,:content, :post_id, :user_id)
  end
end
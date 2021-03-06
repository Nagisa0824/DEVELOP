class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @posts = Post.new
    @post_comment = PostComment.new
  end

  def index
    @post = Post.new
    @user = current_user
    @posts = Post.order(created_at: :desc).where(user_id: [current_user.id, *current_user.following_ids]).page(params[:page]).per(10)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      @user = current_user
      @posts = Post.all
      render :index
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render :edit
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def delete
    @post = Post.find(params[:id])
    @post.destoy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body,:image)
  end
end

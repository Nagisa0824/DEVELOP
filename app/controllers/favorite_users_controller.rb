class FavoriteUsersController < ApplicationController
  def index
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @favorites = Favorite.where(post_id: @post.id)
    #@likes_name = User.find_by(id: @likes.user_id)
  end
end

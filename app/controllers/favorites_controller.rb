class FavoritesController < ApplicationController
  def show
    @user = current_user
    @favorites = Favorite.order("created_at DESC").where(user_id: @user.id).page(params[:page]).per(10)
  end
  
  def user
    @user = current_user
    @post = 
    @user = User.find_by(id: params[:id])
    @favorites = Favorite.where(user_id: @user.id)
  end
  
   def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post_id: params[:post_id])
    favorite.save
    #redirect_to post_path(post)
   end
   
   

  def destroy
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
    #redirect_to post_path(post)
  end
  
end
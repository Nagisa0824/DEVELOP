class FindersController < ApplicationController
  def finder
    @range = params[:range]
    # ユーザー検索の場合
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
     # 投稿検索の場合
    else
      @posts = Post.looks(params[:search], params[:word]).order(created_at: :desc).page(params[:page]).per(10)
    end
  end
end

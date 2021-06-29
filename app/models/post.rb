class Post < ApplicationRecord
  attachment :image
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  # 検索機能
  def self.looks(searches, words)
    if searches == "perfect_match"
      @post = Post.where("body LIKE ?", "#{words}")
    else
      @post = Post.where("body LIKE ?", "%#{words}%")
    end
  end
end
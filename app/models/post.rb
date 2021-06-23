class Post < ApplicationRecord
  attachment :image
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  # 通知機能　紐付け
  has_many :notifications,dependent: :destroy
  
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
  # いいね機能通知
  def create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      post_id:self.id,
      visited_id:self.contributer.id,
      action:"favorite"
    )
    notification.save if notification.valid?
  end
  
  # コメント通知
  
end
class Post < ApplicationRecord
  attachment :image
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  # 通知機能　紐付け
  has_many :notifications, dependent: :destroy
  
  
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
  
  
 def create_notification_favorite!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ",
                                  current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )

      if notification.visitor_id == notification.visited_id
         notification.checked = true
      end
      notification.save if notification.valid?
    end
 end
end
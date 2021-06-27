class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # 通知機能　紐付け
  has_many :notifications, dependent: :destroy
  
  def create_notification_post_comment!(current_user, post_comment_id)
    #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    temp_ids = PostComment.where(post_id: id).where.not("user_id=? or user_id=?", current_user.id,user_id).select(:user_id).distinct
    #取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    #投稿者へ通知を作成
    save_notification_post_comment!(current_user, post_comment_id, user_id)
  end

  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end

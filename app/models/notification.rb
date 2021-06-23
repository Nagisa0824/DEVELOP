class Notification < ApplicationRecord
  
  default_scope->{order(created_at: :desc)}
  belongs_to :post, optional: true

  def create_notification_by(current_user)
      notification=current_user.active_notifications.new(
        micropost_id:self.id,
        visited_id:self.contributer.id,
        action:"favorite"
      )
      notification.save if notification.valid?
  end
end
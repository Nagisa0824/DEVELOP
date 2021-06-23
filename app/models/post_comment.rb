class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # 通知機能　紐付け
  
end

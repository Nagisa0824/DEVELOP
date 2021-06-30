class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

# チャット機能
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  
 has_many :posts, dependent: :destroy
 has_many :postcomments, dependent: :destroy 
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end

  def self.looks(searches, words)
    if searches == "perfect_match"
      @user = User.where("name LIKE ?", "#{words}")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end
  end

  attachment :profile_image, destroy: false
  

end

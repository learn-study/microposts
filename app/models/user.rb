class User < ActiveRecord::Base
  paginates_per 9
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :area, length: { maximum: 12 }
  validates :url , length: { maximum: 255 }
  validates :profile, length: { maximum: 120 }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to:150 },
            on: :update
  has_secure_password
  has_many :microposts
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  has_many :favorites, ->{order("created_at ASC") }, dependent:   :destroy

  has_many :favorite_microposts, through: :favorites, source: :micropost
  def favorite(micropost)
    favorites.find_or_create_by(micropost_id: micropost.id)
  end

  def unfavorite(micropost)
    favorite = favorites.find_by(micropost_id: micropost.id)
    favorite.destroy
  end

  def favorite?(micropost)
    favorite_microposts.include?(micropost)
  end

  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end
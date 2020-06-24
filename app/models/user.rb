class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :tweets
  has_many :comments
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :favorites
  has_many :favorite_tweets, through: :favorites
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def favorited_by?(tweet_id)
    favorites.where(tweet_id: tweet_id).exists?
  end

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  
  mount_uploader :image, ImageUploader
end

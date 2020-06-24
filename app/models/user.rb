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

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def favorited_by?(tweet_id)
    favorites.where(tweet_id: tweet_id).exists?
  end
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end


  def following?(other_user)
    self.followings.include?(other_user)
  end

  mount_uploader :image, ImageUploader
end

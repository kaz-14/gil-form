class GroupTweet < ApplicationRecord
  validates :text, presence: true
  validates :title, presence: true
  belongs_to :group
  belongs_to :user
  has_many :likes
  has_many :opinions
  enum status: { draft: 0, published: 1 }

  acts_as_taggable
  
  mount_uploader :image, ImageUploader

  def self.group_search(search)
    if search
      GroupTweet.where('text LIKE(?)', "%#{search}%")
      GroupTweet.where('title LIKE(?)', "%#{search}%")
    else
      GroupTweet.all
    end
  end
end

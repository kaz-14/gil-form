class GroupTweet < ApplicationRecord
  validates :text, presence: true
  belongs_to :group
  belongs_to :user
  has_many :likes
  has_many :opinions
  enum status: { draft: 0, published: 1 }
  
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

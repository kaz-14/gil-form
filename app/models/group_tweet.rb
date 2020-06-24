class GroupTweet < ApplicationRecord
  belongs_to :group
  belongs_to :user

  mount_uploader :image, ImageUploader

  def self.search(search)
    if search
      GroupTweet.where('text LIKE(?)', "%#{search}%")
    else
      GroupTweet.all
    end
  end
end

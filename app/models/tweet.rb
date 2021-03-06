class Tweet < ApplicationRecord
  validates :text, presence: true
  validates :title, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites
  enum status: { draft: 0, published: 1 }

  acts_as_taggable

  mount_uploader :image, ImageUploader

  def self.search(search)
    if search
      Tweet.where('text LIKE(?)', "%#{search}%")
      Tweet.where('title LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
end
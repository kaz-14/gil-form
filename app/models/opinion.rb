class Opinion < ApplicationRecord
  belongs_to :group_tweet
  belongs_to :user

  validates :text, presence: { message: "入力してください" }
end

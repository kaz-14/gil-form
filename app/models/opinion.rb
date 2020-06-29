class Opinion < ApplicationRecord
  belongs_to :group_tweet
  belongs_to :user
end

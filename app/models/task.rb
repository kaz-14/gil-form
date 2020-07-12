class Task < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, presence: { message: "入力してください" }
  validates :description, presence: { message: "入力してください" }
end

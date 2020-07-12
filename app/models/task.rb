class Task < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, presence: { message: "入力してください" }
  validates :description, presence: { message: "入力してください" }

  enum state: { todo: 0, doing: 1, complete: 2 }
end

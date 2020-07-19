require 'rails_helper'

describe Task do
  describe '#create' do
    it "ユーザー、TODOタイトル、詳細が入っていれば投稿できる " do
      user = FactoryBot.create(:user)
      task = FactoryBot.build(:task,user_id: user.id)
      expect(task).to be_valid
    end

    it "is valid without title " do
      user = FactoryBot.build(:user)
      task = FactoryBot.build(:task, user_id: user.id, title: "")
      task.valid?
      expect(task.errors[:title]).to include("入力してください")
    end

    it "is valid without description " do
      user = FactoryBot.build(:user)
      task = FactoryBot.build(:task, user_id: user.id, description: "")
      task.valid?
      expect(task.errors[:description]).to include("入力してください")
  end
  end
end
require 'rails_helper'

describe Tweet do
  describe '#create' do
    it "ユーザー、テキスト、タイトルが入っていれば投稿できる " do
      user = FactoryBot.create(:user)
      tweet = FactoryBot.build(:tweet,user_id: user.id)
      expect(tweet).to be_valid
    end

    it "is valid without title " do
      user = FactoryBot.build(:user)
      tweet = FactoryBot.build(:tweet, user_id: user.id, title: "")
      tweet.valid?
      expect(tweet.errors[:title]).to include("を入力してください")
    end

    it "is valid without text " do
      user = FactoryBot.build(:user)
      tweet = FactoryBot.build(:tweet, user_id: user.id, text: "")
      tweet.valid?
      expect(tweet.errors[:text]).to include("を入力してください")
  end
  end
end


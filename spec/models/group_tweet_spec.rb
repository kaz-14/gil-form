require 'rails_helper'

describe GroupTweet do
  describe '#create' do
    it "ユーザー、グループ、テキスト、タイトルが入っていれば投稿できる " do
      user = FactoryBot.create(:user)
      group = FactoryBot.create(:group)
      group_tweet = FactoryBot.build(:group_tweet, user_id: user.id, group_id: group.id)
      expect(group_tweet).to be_valid
    end

    it "is valid without title " do
      user = FactoryBot.build(:user)
      group = FactoryBot.build(:group)
      group_tweet = FactoryBot.build(:group_tweet, user_id: user.id, group_id: group.id,title: "")
      group_tweet.valid?
      expect(group_tweet.errors[:title]).to include("を入力してください")
    end

    it "is valid without text " do
      user = FactoryBot.build(:user)
      group = FactoryBot.build(:group)
      group_tweet = FactoryBot.build(:group_tweet, user_id: user.id, group_id: group.id, text: "")
      group_tweet.valid?
      expect(group_tweet.errors[:text]).to include("を入力してください")
  end
  end
end
require 'rails_helper'

describe Comment do
  describe '#create' do
    it "テキストが入っていれば投稿できる " do
      comment = FactoryBot.build(:comment)
      expect(comment).to be_valid
    end

    it "is valid without text " do
      comment = FactoryBot.build(:comment)
      comment.valid?
      expect(comment.errors[:text]).to include( )
  end
  end
end
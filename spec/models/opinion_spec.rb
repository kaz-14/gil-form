require 'rails_helper'

describe Opinion do
  describe '#create' do
    it "テキストが入っていれば投稿できる " do
      opinion = FactoryBot.build(:opinion)
      expect(opinion).to be_valid
    end

    it "is valid without text " do
      opinion = FactoryBot.build(:opinion)
      opinion.valid?
      expect(opinion.errors[:text]).to include( )
  end
  end
end
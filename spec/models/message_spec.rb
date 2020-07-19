require 'rails_helper'

describe Message do
  describe '#create' do
    context 'can save' do
      it 'is valid with content' do
        expect(FactoryBot.build(:message, image: nil)).to be_valid
      end

      it 'is valid with image' do
        expect(FactoryBot.build(:message, content: nil)).to be_valid
      end

      it 'is valid with content and image' do
        expect(FactoryBot.build(:message)).to be_valid
      end
    end

    context 'can not save' do
      it 'is invalid without content and image' do
        message = FactoryBot.build(:message, content: nil, image: nil)
        message.valid?
        expect(message.errors[:content]).to include("を入力してください")
      end

      it 'is invalid without group_id' do
        message = FactoryBot.build(:message, room_id: nil)
        message.valid?
        expect(message.errors[:room]).to include("を入力してください")
      end

      it 'is invaid without user_id' do
        message = FactoryBot.build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
    end
  end
end
FactoryBot.define do
  factory :message do
    content {"こんにちは"}
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/desk2.jpg')) }
    user
    room
  end
end
FactoryBot.define do
  factory :group_tweet do
    text {"hello!"}
    title {"hello"}
    image {"hoge.png"}
    user
    group
  end
end
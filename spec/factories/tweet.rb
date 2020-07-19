FactoryBot.define do
  factory :tweet do
    id    {1}
    title {"HELLO"}
    text {"hello!"}
    image {"hoge.png"}
    user
  end
end
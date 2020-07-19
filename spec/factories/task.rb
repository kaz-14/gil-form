FactoryBot.define do
  factory :task do
    title {"日記"}
    description {"今日から毎日、日記をつける"}
    user
  end
end
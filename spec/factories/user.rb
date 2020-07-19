FactoryBot.define do

  factory :user do
    id                  {1}
    nickname              {"taro"}
    email                 {"kkk@gmail.com"}
    image                 {"pho.png"}
    password              {"aaaaaaaa"}
    password_confirmation {"aaaaaaaa"}
  end

end
FactoryBot.define do
  factory :user do
    name { "test" }
    email { "tanaka@gmail.com" }
    realname { "test" }
    password { "password" }
    password_confirmation { "password" }
  end
end

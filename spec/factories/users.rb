FactoryBot.define do
  factory :user do
    name { "test" }
    email { "tanaka@gmail.com" }
    realname { "test" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end

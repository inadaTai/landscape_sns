FactoryBot.define do
  factory :user do
    name { "test" }
    realname { "test" }
    email { "tanaka@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :other_user, class: User do
    name { "yamamoto" }
    realname { "yamamoto" }
    email { "yamamoto@gmail.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end

FactoryBot.define do
  factory :user do
    name { "test" }
    realname { "test" }
    email { "test@gmail.com" }
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

  factory :tanaka, class: User do
    name { "tanaka" }
    realname { "tanaka" }
    email { "tanaka@gmail.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
  end
end

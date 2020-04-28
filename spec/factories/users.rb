FactoryBot.define do
  factory :user,aliases:[:contributer] do
    name { "test" }
    realname { "test" }
    email { "test@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
    id { "1" }
  end

  factory :other_user, class: User do
    name { "yamamoto" }
    realname { "yamamoto" }
    email { "yamamoto@gmail.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    id { "2" }
  end

  factory :tanaka, class: User do
    name { "tanaka" }
    realname { "tanaka" }
    email { "tanaka@gmail.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    id { "3" }
  end
end

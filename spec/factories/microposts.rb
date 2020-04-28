FactoryBot.define do
  factory :micropost do
    association :contributer, factory: :user
    content { "旅行先で良い景色だなぁ！" }
    picture { File.open("#{Rails.root}/db/images_seeds/1.jpeg") }
    created_at { 10.minutes.ago }
    id {"1"}
  end
end

FactoryBot.define do
  factory :micropost do
    content { "旅行先で良い景色だなぁ！" }
    picture { File.open("#{Rails.root}/db/images_seeds/1.jpeg") }
    created_at { 10.minutes.ago }
  end
end

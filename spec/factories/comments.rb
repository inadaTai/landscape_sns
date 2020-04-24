FactoryBot.define do
  factory :comment do
    association :user, factory: :other_user
    association :micropost
    body { "MyText" }
  end
end

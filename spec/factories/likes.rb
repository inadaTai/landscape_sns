FactoryBot.define do
  factory :like do
    association :user, factory: :other_user
    association :micropost
  end
end

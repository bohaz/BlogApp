FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence }
    association :author, factory: :user
    post
  end
end

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
    comments_counter { 0 }
    likes_counter { 0 }
    association :author, factory: :user
  end
end

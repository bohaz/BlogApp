FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    bio { Faker::Lorem.paragraph }
    photo { Faker::Avatar.image }
    posts_counter { 0 }

    after(:create) do |user, _evaluator|
      create_list(:post, 3, author: user)
    end
  end
end

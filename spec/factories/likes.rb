FactoryBot.define do
  factory :like do
    association :author, factory: :user
    post
  end
end

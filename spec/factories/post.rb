FactoryBot.define do
  factory :post do
    association :user, factory: :user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
end

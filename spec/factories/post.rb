FactoryBot.define do
  factory :post do
    association :author, factory: :user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
  end
end

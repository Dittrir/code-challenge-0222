FactoryBot.define do
  factory :user do
    name { Faker::DcComics.name }
    email { Faker::Internet.email }
    password { Faker::Lorem.word }
    password_confirmation { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    age { Faker::Number.number(digits: 2)}
  end
end

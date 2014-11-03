FactoryGirl.define do
  factory :buyer do
    name { Faker::Company.name }
    code { Faker::Number.number(6) }
    owner { Faker::Name.name }
    industry_id { rand(1..5) }
  end
end

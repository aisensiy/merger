FactoryGirl.define do
  factory :buyer do
    name { Faker::Company.name }
    code { Faker::Number.number(6) }
    owner { Faker::Name.name }
    industry_id { rand(1..5) }
    market_value { rand(5000..100000) }
    t_minus_1_market_value { market_value * 0.8 }
    t_minus_2_market_value { market_value * 0.6 }
    net_profit { rand(1000..9000) }
    t_minus_1_net_profit { rand(1000..9000) }
    t_minus_2_net_profit { rand(1000..9000) }
    operating_income { rand(2000..9000) * 2 }
    t_minus_1_operating_income { rand(2000..7000) * 2 }
    t_minus_2_operating_income { rand(2000..6000) * 2 }
  end
end

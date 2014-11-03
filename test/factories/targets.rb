FactoryGirl.define do
  factory :target do
    name { Faker::Company.name }
    owner { Faker::Name.name }
    create_date { Faker::Date.backward(365 * 3) }
    industry_id { rand(1..5) }
    description { Faker::Lorem.sentence(3, false, 4) }
    address { "#{Faker::Address.city}#{Faker::Address.street_address}"}
    registered_capital { rand(1000..5000)}
    big_stockholder_percent { rand(0.3..0.95) }
    net_assets { rand(1000..9000) }
    liabilities { rand(1000..8000) }
    total_assets { net_assets + liabilities }
    t_minus_1_total_assets { total_assets * 0.8 }
    t_minus_2_total_assets { total_assets * 0.6 }
    t_minus_1_net_assets { net_assets * 0.8 }
    t_minus_2_net_assets { net_assets * 0.6 }
    t_minus_1_operating_income { rand(2000..9000) }
    t_minus_2_operating_income { rand(2000..8000) }
    t_minus_1_net_profit { rand(100..1000) }
    net_profit { rand(500..3000) }
    is_sold false

    factory :sold_target do
      is_sold true
    end
  end
end

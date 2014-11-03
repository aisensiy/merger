FactoryGirl.define do
  factory :deal do
    buyer
    target
    draft_announce_date { Faker::Date.between(2.years.ago, 10.days.ago) }
    sequence(:report_name) { |n| "Report #{n}" }
    sequence(:consultant) { |n| "Consultant #{n}" }
    pay_method "股份 + 现金"
    financing { rand(0..5.0) }
    finacing_target ""
    finacing_use ""
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
    t_plus_1_net_profit { net_profit * 1.2 }
    t_plus_2_net_profit { net_profit * 1.4 }
    t_plus_3_net_profit { net_profit * 1.6 }
    valuation { rand(1..10) * total_assets }
    valuation_method "收益法"
    valuation_date  { draft_announce_date - 31.days }
    transaction_price { valuation }
    trading_book_value 13.22
    static_earnings 49.1
    trading_earnings 14.7
    three_year_avg_earnings 11.25
  end
end

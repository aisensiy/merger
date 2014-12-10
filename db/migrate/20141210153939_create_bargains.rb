class CreateBargains < ActiveRecord::Migration
  def change
    create_table :bargains do |t|
      t.string :payment_type
      t.string :consultant
      t.integer :year
      t.date :sale_at
      t.string :buyer_name
      t.string :buyer_stock_code
      t.string :buyer_industry
      t.string :bargain_type
      t.float :support_fund
      t.string :support_fund_use
      t.float :bargain_value
      t.date :value_at

      t.float :target_estimate_value
      t.string :target_name
      t.string :target_industry
      t.string :target_business
      t.float :target_net_asset
      t.float :target_income
      t.float :net_profit
      t.float :net_profit_t
      t.float :net_profit_t_1
      t.float :net_profit_t_2
      t.float :net_profit_t_3
      t.float :capital_based_value
      t.float :profit_based_value
      t.float :market_based_value
      t.string :pricing_method
      t.float :growth_ratio
      t.float :static_pe
      t.float :dynamic_pe
      t.float :ps
      t.float :pb
      t.text :memo

      t.timestamps
    end
  end
end

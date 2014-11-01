class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :buyer_id
      t.integer :target_id

      t.date :draft_announce_date
      t.string :report_name
      t.string :consultant
      t.string :pay_method
      t.float :financing
      t.string :finacing_issuer
      t.string :finacing_use

      t.float :net_assets
      t.float :liabilities
      t.float :total_assets
      t.float :t_minus_1_total_assets
      t.float :t_minus_2_total_assets
      t.float :t_minus_1_operating_income
      t.float :t_minus_2_operating_income
      t.float :t_minus_1_net_profit
      t.float :net_profit
      t.float :t_plus_1_net_profit
      t.float :t_plus_2_net_profit
      t.float :t_plus_3_net_profit

      t.float :valuation
      t.string :valuation_method
      t.date :valuation_date
      t.float :transaction_price
      t.float :trading_book_value
      t.float :static_earnings
      t.float :trading_earnings
      t.float :three_year_avg_earnings

      t.timestamps
    end
  end
end

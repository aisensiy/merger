class CreateTargetV2s < ActiveRecord::Migration
  def change
    create_table :target_v2s do |t|
      t.string :company_name
      t.string :stock_code
      t.string :status
      t.string :contact
      t.string :telephone
      t.string:target_industry

      t.float :target_income
      t.float :net_profit
      t.float :net_profit_t
      t.float :net_profit_t_1
      t.float :net_profit_t_2
      t.float :net_profit_t_3
      t.float :estimate_growth
      t.float :estimate_net_profit
      t.float :expected_value
      t.float :market_share

      t.string :pe_vc_holder
      t.timestamps
    end
  end
end

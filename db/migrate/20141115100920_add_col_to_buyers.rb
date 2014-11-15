class AddColToBuyers < ActiveRecord::Migration
  def change
    add_column :buyers, :market_value, :float
    add_column :buyers, :t_minus_1_market_value, :float
    add_column :buyers, :t_minus_2_market_value, :float
    add_column :buyers, :net_profit, :float
    add_column :buyers, :t_minus_1_net_profit, :float
    add_column :buyers, :t_minus_2_net_profit, :float
    add_column :buyers, :operating_income, :float
    add_column :buyers, :t_minus_1_operating_income, :float
    add_column :buyers, :t_minus_2_operating_income, :float
  end
end

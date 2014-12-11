class AddColsToTargetV2s < ActiveRecord::Migration
  def change
    add_column :target_v2s, :garden, :string
    add_column :target_v2s, :income_growth, :float
    add_column :target_v2s, :market_value, :float
    add_column :target_v2s, :net_asset, :float
    add_column :target_v2s, :net_capital, :float
    add_column :target_v2s, :net_profit_growth, :float
    add_column :target_v2s, :stock_share, :float
    add_column :target_v2s, :total_debt, :float
  end
end

class CreateBuyerV2s < ActiveRecord::Migration
  def change
    create_table :buyer_v2s do |t|
      t.string :stock_code
      t.string :company_name
      t.string :actual_controller
      t.float :ssh_prop

      t.string :owner_type
      t.integer :bargain_freq
      t.date :ipo_at
      t.date :start_at
      t.string :industry
      t.text :main_product
      t.string :main_product_type
      t.string :region
      t.float :cash_reserve_2
      t.float :cash_reserve_3
      t.float :cash_reserve_1
      t.float :growth_ratio_1
      t.float :growth_ratio_2
      t.float :growth_ratio_3
      t.float :net_profit
      t.float :roe
      t.string :concept_sector
      t.integer :row_index
      t.float :pe
      t.float :market_value
      t.float :pb

      t.timestamps
    end
  end
end

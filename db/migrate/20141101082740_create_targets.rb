class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :name
      t.string :owner
      t.date :create_date
      t.integer :industry_id
      t.text :description
      t.string :address
      t.integer :registered_capital
      t.float :big_stockholder_percent

      t.float :net_assets
      t.float :liabilities
      t.float :total_assets
      t.float :t_minus_1_total_assets
      t.float :t_minus_2_total_assets
      t.float :t_minus_1_operating_income
      t.float :t_minus_2_operating_income
      t.float :t_minus_1_net_profit
      t.float :net_profit

      t.boolean :is_sold

      t.timestamps
    end
  end
end

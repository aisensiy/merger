class AddCapitalToTargetV2s < ActiveRecord::Migration
  def change
    add_column :target_v2s, :capital, :float
  end
end

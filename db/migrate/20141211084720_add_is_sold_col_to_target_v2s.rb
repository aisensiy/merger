class AddIsSoldColToTargetV2s < ActiveRecord::Migration
  def change
    add_column :target_v2s, :is_sold, :boolean
  end
end

class AddColumnIsSoldToTarget < ActiveRecord::Migration
  def change
    add_column :targets, :is_sold, :boolean
  end
end

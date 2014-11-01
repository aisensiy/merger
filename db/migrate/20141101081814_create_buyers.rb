class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :name
      t.string :code
      t.string :owner
      t.integer :industry_id

      t.timestamps
    end
  end
end

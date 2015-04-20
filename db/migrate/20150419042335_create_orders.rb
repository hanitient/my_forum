class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :kind
      t.string :address
      t.integer :price
      t.string :describe

      t.timestamps null: false
    end
  end
end

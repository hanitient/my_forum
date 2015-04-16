class AddPriceToTeas < ActiveRecord::Migration
  def change
    add_column :teas, :price, :integer
  end
end

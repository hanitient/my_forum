class CreateTeas < ActiveRecord::Migration
  def change
    create_table :teas do |t|
      t.string :name
      t.string :kind
      t.text :describe

      t.timestamps null: false
    end
  end
end

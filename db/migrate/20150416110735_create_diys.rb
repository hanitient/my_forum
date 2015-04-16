class CreateDiys < ActiveRecord::Migration
  def change
    create_table :diys do |t|
      t.string :name
      t.text :describe

      t.timestamps null: false
    end
  end
end

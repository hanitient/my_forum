class AddUserIdToDiys < ActiveRecord::Migration
  def change
  	    add_column :diys, :user_id, :integer
  end
end

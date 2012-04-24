class AddUserToFood < ActiveRecord::Migration
  def up
    add_column :foods, :user_id, :decimal
  end

  def down
    remove_column :foods, :user_id, :decimal
  end
end

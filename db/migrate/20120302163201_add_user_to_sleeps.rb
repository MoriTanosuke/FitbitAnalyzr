class AddUserToSleeps < ActiveRecord::Migration
  def up
    add_column :sleeps, :user_id, :decimal
  end

  def down
    remove_column :sleeps, :user_id, :decimal
  end
end

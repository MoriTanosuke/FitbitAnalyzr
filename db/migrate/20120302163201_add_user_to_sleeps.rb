class AddUserToSleeps < ActiveRecord::Migration
  def up
    add_column :sleeps, :user_id, :number
  end

  def down
    remove_column :sleeps, :user_id, :number
  end
end

class AddLastloginColumnToUser < ActiveRecord::Migration
  def up
    add_column :users, :last_login, :date
  end

  def down
    remove_Column :users, :last_login
  end
end

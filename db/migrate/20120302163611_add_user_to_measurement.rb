class AddUserToMeasurement < ActiveRecord::Migration
  def up
    add_column :measurements, :user_id, :decimal
  end

  def down
    remove_column :measurements, :user_id
  end
end

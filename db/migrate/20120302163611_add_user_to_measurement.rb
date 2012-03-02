class AddUserToMeasurement < ActiveRecord::Migration
  def change
    add_column :measurements, :user_id, :number
  end
end

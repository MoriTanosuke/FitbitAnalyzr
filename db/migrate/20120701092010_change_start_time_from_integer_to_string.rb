class ChangeStartTimeFromIntegerToString < ActiveRecord::Migration
  def up
    change_column :sleeps, :startTime, :string
  end

  def down
    change_column :sleeps, :startTime, :integer
  end
end

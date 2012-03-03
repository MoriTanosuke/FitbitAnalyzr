class DeleteDurationFromSleep < ActiveRecord::Migration
  def up
    remove_column :sleeps, :duration
  end

  def down
    add_column :sleeps, :duration, :number
  end
end

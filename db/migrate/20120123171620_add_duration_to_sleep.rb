class AddDurationToSleep < ActiveRecord::Migration
  def change
    add_column :sleeps, :duration, :integer
  end
end

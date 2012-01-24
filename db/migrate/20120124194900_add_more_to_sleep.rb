class AddMoreToSleep < ActiveRecord::Migration
  def change  
    add_column :sleeps, :awakeningscount, :integer
    add_column :sleeps, :minutesToFallAsleep, :integer
    add_column :sleeps, :efficiency, :integer
    add_column :sleeps, :minutesAsleep, :integer
    add_column :sleeps, :timeInBed, :integer
    add_column :sleeps, :startTime, :integer
    add_column :sleeps, :minutesAwake, :integer
    add_column :sleeps, :minutesAfterWakeup, :integer
  end
end


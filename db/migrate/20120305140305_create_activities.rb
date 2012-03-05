class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.decimal :user_id
      t.date :date
      t.decimal :calories
      t.decimal :steps
      t.decimal :distance
      t.decimal :floors
      t.decimal :elevation
      t.decimal :minutesSedentary
      t.decimal :minutesLightlyActive
      t.decimal :minutesFairlyActive
      t.decimal :minutesVeryActive
      t.decimal :activeScore
      t.decimal :activityCalories
      t.timestamps
    end
  end
end

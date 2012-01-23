class CreateSleeps < ActiveRecord::Migration
  def change
    create_table :sleeps do |t|
      t.date :date
      t.string :data

      t.timestamps
    end
  end
end

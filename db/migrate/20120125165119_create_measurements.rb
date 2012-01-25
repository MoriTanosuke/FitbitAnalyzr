class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.datetime :date
      t.text :data
      t.decimal :bmi
      t.decimal :fat
      t.decimal :weight

      t.timestamps
    end
  end
end

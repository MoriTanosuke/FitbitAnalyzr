class ChangeDataTypeForMeasurementDate < ActiveRecord::Migration
  def up
    change_table :measurements do |t|
      t.change :date, :date
    end
  end

  def down
    change_table :measurements do |t|
      t.change :date, :datetime
    end
  end
end

class ChangeDataTypeForSleepData < ActiveRecord::Migration
  def up
    change_table :sleeps do |t|
      t.change :data, :text
    end
  end

  def down
    change_table :sleeps do |t|
      t.change :data, :string
    end
  end
end

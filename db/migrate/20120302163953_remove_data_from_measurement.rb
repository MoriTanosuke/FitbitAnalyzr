class RemoveDataFromMeasurement < ActiveRecord::Migration
  def up
	remove_column :measurements, :data
  end

  def down
	add_column :measurements, :data, :string
  end
end

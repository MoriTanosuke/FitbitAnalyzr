class RemoveDataFromSleep < ActiveRecord::Migration
  def up
	remove_column :sleeps, :data
  end

  def down
	add_column :sleeps, :data, :string
  end
end

class RenameAwakeningscountInSleep < ActiveRecord::Migration
  def up
    rename_column :sleeps, :awakeningscount, :awakeningsCount
  end

  def down
    rename_column :sleeps, :awakeningsCount, :awakeningscount
  end
end

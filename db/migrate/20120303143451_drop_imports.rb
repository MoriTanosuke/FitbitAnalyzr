class DropImports < ActiveRecord::Migration
  def up
    drop_table :imports
  end

  def down
  end
end

class AddRangeToImports < ActiveRecord::Migration
  def change
    add_column :imports, :range, :string
  end
end

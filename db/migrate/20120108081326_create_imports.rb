class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :user
      t.date :date
      t.text :data

      t.timestamps
    end
  end
end

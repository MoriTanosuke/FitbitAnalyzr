class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.date :date
      t.decimal :caloriesIn
      t.decimal :carbs
      t.decimal :fat
      t.decimal :fiber
      t.decimal :protein
      t.decimal :sodium
      t.decimal :water
      t.timestamps
    end
  end
end

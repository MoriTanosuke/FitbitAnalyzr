class CreateCustomData < ActiveRecord::Migration
  def change
    create_table :custom_data do |t|
      t.date :date
      t.string :name
      t.decimal :value

      t.decimal :user_id
      t.timestamps
    end
  end
end

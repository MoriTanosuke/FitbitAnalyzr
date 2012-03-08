class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :collection_path
      t.string :subscription_id
      t.datetime :created_at
      t.decimal :user_id

      t.timestamps
    end
  end
end

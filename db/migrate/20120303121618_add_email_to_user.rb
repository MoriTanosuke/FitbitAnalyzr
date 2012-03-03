class AddEmailToUser < ActiveRecord::Migration
  def up
	add_column :users, :email, :string
        User.all.each do |u|
	  u.email = u.name
	  u.save
	end
        remove_column :users, :name
  end

  def down
    add_column :users, :name, :string
    User.all.each do |u|
      u.name = u.email
      u.save
    end
    remove_column :users, :string
  end
end

class AddFeetTallandInchesTallToUsers < ActiveRecord::Migration[5.1]
  add_column :users, :feet_tall, :integer
  add_column :users, :inches_tall, :integer
end

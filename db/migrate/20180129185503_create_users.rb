class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :age
      t.integer :height_in_inches
      t.integer :weight_in_lb
      t.string :fave_color

      t.timestamps
    end
  end
end

class RemoveHeightFromUsers < ActiveRecord::Migration[5.1]
  remove_column :users, :height_in_inches
end

class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_password_token, :string
    add_index :users, :reset_password_token
  end
end

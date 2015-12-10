class AddColumnsToUser < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email_address, :string
    add_column :users, :confirmation_token, :string
    add_column :users, :is_confirmed, :boolean, :default => 0
  end

  def down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :email_address
    remove_column :users, :confirmation_token
    remove_column :users, :is_confirmed
  end
end

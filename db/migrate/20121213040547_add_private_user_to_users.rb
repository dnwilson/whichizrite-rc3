class AddPrivateUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private_user, :boolean, :default => false
  end
end

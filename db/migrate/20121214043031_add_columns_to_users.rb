class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :profilepic, :string
    add_column :users, :private_followable, :boolean, :default => false
  end
end

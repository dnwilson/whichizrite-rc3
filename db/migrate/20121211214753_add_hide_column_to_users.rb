class AddHideColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hide, :boolean, :default => false
  end
end

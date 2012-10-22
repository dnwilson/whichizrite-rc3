class AddWebsiteColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :website, :string
    add_column :users, :country_name, :string
  end
end

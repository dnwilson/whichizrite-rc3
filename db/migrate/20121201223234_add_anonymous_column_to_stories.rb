class AddAnonymousColumnToStories < ActiveRecord::Migration
  def change
    add_column :stories, :anonymous, :boolean, :default => false
  end
end

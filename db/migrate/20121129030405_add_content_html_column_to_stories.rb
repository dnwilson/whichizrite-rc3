class AddContentHtmlColumnToStories < ActiveRecord::Migration
  def change
  	add_column :stories, :content_html, :string
  	t.boolean :anonymous, :default => false
  end
end

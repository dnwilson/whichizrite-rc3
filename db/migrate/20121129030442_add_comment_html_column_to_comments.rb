class AddCommentHtmlColumnToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :comment_html, :string
  end
end

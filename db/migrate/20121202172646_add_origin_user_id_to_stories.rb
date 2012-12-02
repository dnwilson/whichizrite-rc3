class AddOriginUserIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :origin_user_id, :integer
  end
end

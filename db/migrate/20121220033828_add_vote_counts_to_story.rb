class AddVoteCountsToStory < ActiveRecord::Migration
  def change
    add_column :stories, :upcount, :integer, :default => 0
    add_column :stories, :downcount, :integer, :default => 0
  end
end

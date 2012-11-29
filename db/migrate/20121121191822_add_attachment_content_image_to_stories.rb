class AddAttachmentContentImageToStories < ActiveRecord::Migration
  def self.up
    change_table :stories do |t|

      t.has_attached_file :content_image

    end
  end

  def self.down

    drop_attached_file :stories, :content_image

  end
end


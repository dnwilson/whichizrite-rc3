class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.string :title
      t.text :content

      t.timestamps
    end
    
    add_index :stories, [:user_id, :id]
  end
end

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :story_id
      t.string :comment

      t.timestamps
    end

    add_index :comments, [:story_id, :user_id, :id] 
  end
end

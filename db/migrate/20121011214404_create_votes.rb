class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :story_id
      t.boolean :wir

      t.timestamps
    end
  end
end

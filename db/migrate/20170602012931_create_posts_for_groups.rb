class CreatePostsForGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :group_id
      t.integer :user_id
      
      t.timestamps
    end
    add_index :posts, :group_id
    add_index :posts, :user_id
  end
end

class CreatePostReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.text :content
      t.integer :post_id
      t.string :commentable_type
      
      t.timestamps
    end
  end
end

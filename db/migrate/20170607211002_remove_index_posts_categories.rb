class RemoveIndexPostsCategories < ActiveRecord::Migration[5.0]
  def change
    remove_index :posts, :category_id
    add_index :posts, :category_id
  end
end

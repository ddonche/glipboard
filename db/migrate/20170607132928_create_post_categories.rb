class CreatePostCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.text :name
      t.integer :category_id
      t.integer :group_id

      t.timestamps
    end
    add_index :categories, :group_id
  end
end

class CreateOfficialBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.integer :guest_id
      t.string :slug
      t.string :image
      

      t.timestamps
    end
  end
end

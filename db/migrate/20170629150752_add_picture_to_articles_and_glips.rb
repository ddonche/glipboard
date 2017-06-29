class AddPictureToArticlesAndGlips < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :picture, :string
    add_column :glips, :picture, :string
  end
end

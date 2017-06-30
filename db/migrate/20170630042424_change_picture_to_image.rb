class ChangePictureToImage < ActiveRecord::Migration[5.0]
  def change
    rename_column :articles, :picture, :image
    rename_column :glips, :picture, :image
  end
end

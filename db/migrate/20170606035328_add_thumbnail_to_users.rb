class AddThumbnailToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :thumbnail, :string
    add_column :groups, :picture, :string
  end
end

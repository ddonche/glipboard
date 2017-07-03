class AddStickyToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :sticky, :integer, default: 0
    add_column :posts, :comments_disabled, :integer, default: 0
  end
end

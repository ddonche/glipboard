class AddBlogEnumToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :blog, :integer, default: 0
  end
end

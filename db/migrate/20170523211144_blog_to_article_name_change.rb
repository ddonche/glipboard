class BlogToArticleNameChange < ActiveRecord::Migration[5.0]
  def change
    rename_table :blogs, :articles
  end
end

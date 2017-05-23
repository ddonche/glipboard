class BlogToArticleNameChange < ActiveRecord::Migration[5.0]
  def change
    rename_table :blogs, :articles
    rename_index :articles, :index_blogs_on_slug, :index_articles_on_slug
  end
end

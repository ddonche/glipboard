class RenameArticlesToBlogs < ActiveRecord::Migration[5.0]
  def self.up
    rename_table :articles, :blogs
  end

  def self.down
    rename_table :blogs, :articles
  end
end

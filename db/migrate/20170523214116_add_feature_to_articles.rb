class AddFeatureToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :feature, :integer, default: 0
  end
end

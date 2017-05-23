class ChangeArticlesFeatureDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :articles, :feature, 0
  end
end

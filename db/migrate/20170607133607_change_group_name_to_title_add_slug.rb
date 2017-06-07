class ChangeGroupNameToTitleAddSlug < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :name, :title
    add_column :categories, :slug, :string
    add_index :categories, :slug, unique: true
  end 
end

class AddSlugToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :slug, :string
    add_index :groups, :slug, unique: true
    add_index :groups, :name, :unique => true
  end
end

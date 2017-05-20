class AddSlugToGlips < ActiveRecord::Migration[5.0]
  def change
    add_column :glips, :slug, :string
    add_index :glips, :slug, unique: true
  end
end

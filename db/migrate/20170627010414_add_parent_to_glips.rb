class AddParentToGlips < ActiveRecord::Migration[5.0]
  def change
    add_column :glips, :parent_id, :integer
  end
end

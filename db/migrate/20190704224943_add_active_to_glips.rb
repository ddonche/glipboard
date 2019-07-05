class AddActiveToGlips < ActiveRecord::Migration[5.0]
  def change
    add_column :glips, :active, :integer, default: 0
  end
end

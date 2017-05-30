class AddVerifiedToGlips < ActiveRecord::Migration[5.0]
  def change
    add_column :glips, :verified, :integer, default: 0
  end
end
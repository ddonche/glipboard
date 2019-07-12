class AddPrivacyToGlips < ActiveRecord::Migration[5.0]
  def change
    add_column :glips, :privacy, :integer, default: 0
  end
end

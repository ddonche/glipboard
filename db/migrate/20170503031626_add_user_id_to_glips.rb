class AddUserIdToGlips < ActiveRecord::Migration[5.0]
  def change
    add_column :glips, :user_id, :integer
  end
end

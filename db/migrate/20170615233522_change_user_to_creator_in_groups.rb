class ChangeUserToCreatorInGroups < ActiveRecord::Migration[5.0]
  def change
    rename_column :groups, :user_id, :creator_id
  end
end

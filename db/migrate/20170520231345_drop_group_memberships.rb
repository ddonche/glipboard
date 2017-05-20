class DropGroupMemberships < ActiveRecord::Migration[5.0]
  def change
    drop_table :group_memberships
  end
end

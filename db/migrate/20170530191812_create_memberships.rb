class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
    add_index :memberships, :group_id
    add_index :memberships, :user_id
    add_index :memberships, [:group_id, :user_id], unique: true
  end
end

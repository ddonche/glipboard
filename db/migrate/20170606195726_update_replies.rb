class UpdateReplies < ActiveRecord::Migration[5.0]
  def change
    add_column :replies, :user_id, :integer
    remove_column :replies, :commentable_type, :string
  end
end

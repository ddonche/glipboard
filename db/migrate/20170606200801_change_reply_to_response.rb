class ChangeReplyToResponse < ActiveRecord::Migration[5.0]
  def change
    rename_table :replies, :responses
  end 
end

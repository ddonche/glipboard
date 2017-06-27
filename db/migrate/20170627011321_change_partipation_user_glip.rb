class ChangePartipationUserGlip < ActiveRecord::Migration[5.0]
  def change
    rename_column :participations, :parent_id, :glip_id
    rename_column :participations, :participant_id, :user_id
  end
end

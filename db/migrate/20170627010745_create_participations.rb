class CreateParticipations < ActiveRecord::Migration[5.0]
  def change
    create_table :participations do |t|
      t.integer :parent_id
      t.integer :participant_id

      t.timestamps
    end
    add_index :participations, :parent_id
    add_index :participations, :participant_id
    add_index :participations, [:parent_id, :participant_id], unique: true
  end
end

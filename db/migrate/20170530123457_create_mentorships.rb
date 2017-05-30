class CreateMentorships < ActiveRecord::Migration[5.0]
  def change
    create_table :mentorships do |t|
      t.integer :article_id
      t.integer :glip_id

      t.timestamps
    end
    add_index :mentorships, :article_id
    add_index :mentorships, :glip_id
    add_index :mentorships, [:article_id, :glip_id], unique: true
  end
end

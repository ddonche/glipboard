class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.integer :glip_id
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

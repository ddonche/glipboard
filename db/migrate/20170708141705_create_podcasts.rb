class CreatePodcasts < ActiveRecord::Migration[5.0]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.text :content
      t.text :group_id
      t.text :user_id

      t.timestamps
    end
    add_index :podcasts, :group_id
    add_index :podcasts, :user_id
  end
end

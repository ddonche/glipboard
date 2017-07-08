class CreateEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :content
      t.integer :podcast_id
      t.integer :user_id

      t.timestamps
    end
  end
end

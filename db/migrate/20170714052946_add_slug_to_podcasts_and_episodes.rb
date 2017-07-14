class AddSlugToPodcastsAndEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :podcasts, :slug, :string
    add_index :podcasts, :slug, unique: true
    add_column :episodes, :slug, :string
    add_index :episodes, :slug, unique: true
  end
end

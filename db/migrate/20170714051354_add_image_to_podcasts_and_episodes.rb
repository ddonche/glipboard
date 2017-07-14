class AddImageToPodcastsAndEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :podcasts, :image, :string
    add_column :episodes, :image, :string
  end
end

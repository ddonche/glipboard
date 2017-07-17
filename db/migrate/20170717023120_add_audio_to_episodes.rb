class AddAudioToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :audio, :string
  end
end

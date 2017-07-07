class AddYoutubeToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :youtube, :string
    add_column :responses, :youtube, :string
  end
end

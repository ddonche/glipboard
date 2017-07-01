class AddSubtitleToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :subtitle, :string
  end
end

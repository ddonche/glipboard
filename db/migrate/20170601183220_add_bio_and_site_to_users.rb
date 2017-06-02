class AddBioAndSiteToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bio, :string
    add_column :users, :website, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
  end
end

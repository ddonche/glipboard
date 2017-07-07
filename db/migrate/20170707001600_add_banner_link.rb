class AddBannerLink < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :banner_url, :string
    add_column :groups, :side_ad, :string
    add_column :groups, :side_ad_url, :string
  end
end

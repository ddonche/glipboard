class ChangeBannerUrlToLink < ActiveRecord::Migration[5.0]
  def change
    rename_column :groups, :banner_url, :banner_link
    rename_column :groups, :side_ad_url, :side_ad_link
  end
end

class AddOtherPicsToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :icon, :string
    add_column :groups, :banner, :string
  end
end

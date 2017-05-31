class RenameGroupNameToGroupTitle < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :groups, :name, :title
  end

  def self.down
    rename_column :groups, :title, :name
  end
end

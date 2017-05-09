class RemoveNamesFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :firstname, :string
    remove_column :users, :lastname, :string
  end
end

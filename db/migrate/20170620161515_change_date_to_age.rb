class ChangeDateToAge < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :date, :birthdate
  end
end

class ChangeUserRepDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :reputation, 0
  end
end

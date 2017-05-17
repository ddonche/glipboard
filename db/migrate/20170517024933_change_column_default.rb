class ChangeColumnDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :blogs, :status, 0
  end
end

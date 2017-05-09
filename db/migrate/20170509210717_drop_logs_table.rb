class DropLogsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :logs
  end
end

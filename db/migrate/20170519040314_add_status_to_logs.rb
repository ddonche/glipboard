class AddStatusToLogs < ActiveRecord::Migration[5.0]
  def change
    add_column :logs, :status, :integer, default: 0
  end
end

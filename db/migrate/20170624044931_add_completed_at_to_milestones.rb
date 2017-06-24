class AddCompletedAtToMilestones < ActiveRecord::Migration[5.0]
  def change
    add_column :milestones, :completed_at, :datetime
  end
end

class AddTimestampsToMentorships < ActiveRecord::Migration[5.0]
    def change_table
      add_column(:mentorships, :created_at, :datetime)
    end
end

class AddDeadlineToGlips < ActiveRecord::Migration[5.0]
  def change
    add_column('glips', 'deadline', :datetime)
  end
end

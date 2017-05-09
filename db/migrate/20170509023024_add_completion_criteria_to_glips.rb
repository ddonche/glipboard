class AddCompletionCriteriaToGlips < ActiveRecord::Migration[5.0]
  def change
    add_column :glips, :completion_criteria, :text
  end
end

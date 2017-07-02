class CreateRemark < ActiveRecord::Migration[5.0]
  def change
    create_table :remarks do |t|
      t.text :content
      t.integer :response_id
      t.integer :user_id
      
      t.timestamps
    end
  end
end

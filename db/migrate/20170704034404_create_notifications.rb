class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :recipient, index: true
      t.references :notified_by, index: true
      t.references :glip, index: true
      t.references :article, index: true
      t.references :group, index: true
      t.references :post, index: true
      t.references :comment, index: true
      t.references :notation, index: true
      t.references :response, index: true
      t.references :remark, index: true
      t.references :conversation, index: true
      t.references :message, index: true
      t.boolean :read, default: false

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users, column: :recipient_id
    add_foreign_key :notifications, :users, column: :notified_by_id
    add_foreign_key :notifications, :glips
    add_foreign_key :notifications, :articles
    add_foreign_key :notifications, :groups
    add_foreign_key :notifications, :posts
    add_foreign_key :notifications, :comments
    add_foreign_key :notifications, :notations
    add_foreign_key :notifications, :responses
    add_foreign_key :notifications, :remarks
    add_foreign_key :notifications, :conversations
    add_foreign_key :notifications, :messages
  end
end

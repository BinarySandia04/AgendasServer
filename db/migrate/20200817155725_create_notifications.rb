class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id

      t.text :title
      t.text :content
      t.text :action

      t.boolean :unread
      t.timestamps
    end
  end
end

class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id

      t.text :title
      t.text :content

      t.string :action
      t.string :deny_action

      t.string :action_name
      t.string :deny_action_name

      t.boolean :confirmable

      t.boolean :unread
      t.timestamps
    end
  end
end

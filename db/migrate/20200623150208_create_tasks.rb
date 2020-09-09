class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :start
      t.integer :duration
      t.text :description

      t.integer :group_id
      t.integer :category_id
      t.integer :user_id
      t.text :desc

      t.timestamps
    end
  end
end

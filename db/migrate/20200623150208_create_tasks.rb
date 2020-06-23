class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :start
      t.integer :duration
      t.text :description

      t.timestamps
    end
  end
end

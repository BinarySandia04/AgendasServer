class CreateAssigments < ActiveRecord::Migration[6.0]
  def change
    create_table :assigments do |t|
      t.integer :user_id
      t.integer :task_id
      t.boolean :is_done

      t.timestamps
    end
  end
end

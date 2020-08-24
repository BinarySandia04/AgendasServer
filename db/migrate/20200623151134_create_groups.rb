class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :desc
      t.string :code

      t.integer :creator_id

      t.timestamps
    end
  end
end

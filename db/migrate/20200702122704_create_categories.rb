class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :group_id
      t.text :desc

      t.integer :accentcolor

      t.timestamps
    end
  end
end

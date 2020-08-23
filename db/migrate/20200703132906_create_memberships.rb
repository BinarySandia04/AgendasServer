class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :role
      t.integer :number # Usado para conseguir rapidamente un identificador del usuario dentro del grupo

      t.timestamps
    end
  end
end

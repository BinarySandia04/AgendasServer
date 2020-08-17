class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.integer :group_id
      t.integer :sender_id
      t.integer :recipent_id

      t.timestamps
    end
  end
end

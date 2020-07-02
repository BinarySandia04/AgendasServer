class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :password

      t.string :displayname
      t.string :name
      t.string :surname
      t.string :sex
      t.date :birthdate
      t.text :description
      t.string :status

      t.string :role

      t.timestamps
    end
  end
end

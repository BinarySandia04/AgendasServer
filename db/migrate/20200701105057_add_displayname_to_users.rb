class AddDisplaynameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :displayname, :string
  end
end

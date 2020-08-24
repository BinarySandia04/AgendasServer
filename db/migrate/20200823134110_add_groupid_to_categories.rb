class AddGroupidToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :group_id, :integer
  end
end

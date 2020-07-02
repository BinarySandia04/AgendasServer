class Group < ApplicationRecord
  has_many :tasks
  has_and_belongs_to_many :users

  before_create :generate_code

  private
  def generate_code
    update_column :code, SecureRandom.hex(4)
  rescue ActiveRecord::RecordNotUnique
    retry
  end
end

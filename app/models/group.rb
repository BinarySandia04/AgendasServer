class Group < ApplicationRecord
  has_many :tasks
  has_and_belongs_to_many :users
end

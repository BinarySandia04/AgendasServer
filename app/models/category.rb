class Category < ApplicationRecord
  belongs_to :group
  has_many :tasks
end

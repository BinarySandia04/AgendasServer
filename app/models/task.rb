class Task < ApplicationRecord
  belongs_to :group
  has_many :categories, through: :group
end

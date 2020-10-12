class Task < ApplicationRecord
  belongs_to :group
  belongs_to :category
  belongs_to :user

  has_many :assigments

  has_one_attached :file


end

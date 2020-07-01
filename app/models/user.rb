class User < ApplicationRecord
  has_secure_password :password

  has_one_attached :avatar

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  has_and_belongs_to_many :groups
end

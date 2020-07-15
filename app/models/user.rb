class User < ApplicationRecord
  has_secure_password :password

  has_one_attached :avatar

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :invitations, :class_name => "Invitation", :foreign_key => "recipent_id"
  has_many :sent_invitations, :class_name => "Invitation", :foreign_key => 'sender_id'

  before_create :confirmation_token

  after_commit :flush_cache

  def flush_cache
    Rails.cache.delete('users')
  end

  def activate_email
    self.email_confirmed = true
    self.confirm_token = nil

    save!(validate: false) # Guarda sin validar (ya lo hemos hecho)
  end

  class << self
    def get_from_cache(user_id)
      Rails.cache.fetch('users') {User.find(user_id)}
    end
  end

  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end

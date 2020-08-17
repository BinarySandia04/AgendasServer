class User < ApplicationRecord
  has_secure_password :password

  has_one_attached :avatar

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :notifications

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

  def getRankFromGroup(group)
    return memberships.find_by(group: group).role
  rescue ActiveRecord::RecordNotFound
    return nil
  end

  def resize_image
    resized_image = MiniMagick::Image.read(avatar)
    resized_image = resized_image.resize("300x300")
    resized_image = resized_image.format('jpg')
    v_filename = avatar.filename
    v_content_type = avatar.content_type
    avatar.purge
    avatar.attach(io: File.open(resized_image.path), filename: v_filename, content_type: v_content_type)
  end

  class << self
    def get_from_cache(user_id)
      return Rails.cache.fetch('users') {User.find(user_id)}
      rescue ActiveRecord::RecordNotFound
        return nil
    end
  end

  def avatar_formatting
    return unless avatar.attached?
    if avatar.blob.content_type.start_with? 'image/'
      if avatar.blob.byte_size > 3.megabytes
        errors.add(:avatar, 'size needs to be less than 10MB')
        avatar.purge
      else
        resize_image
      end
    else
      avatar.purge
      errors.add(:avatar, 'needs to be an image')
    end
  end

  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end

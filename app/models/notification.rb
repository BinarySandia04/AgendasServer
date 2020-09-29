class Notification < ApplicationRecord
  belongs_to :user

  before_create :set_unread

  def self.create(user, title, content)
    notification = Notification.new()

    notification.user_id = user.id
    notification.title = title
    notification.content = content

    if notification.save
      return notification
    else
      # Fuego en la casa
      return nil
    end
  end

  protected
  def set_unread
    self.unread = true
    self.confirmable = false
  end
end

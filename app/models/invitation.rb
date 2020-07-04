class Invitation < ApplicationRecord
  belongs_to :group
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipent, :class_name => 'User'

  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.group_id, Time.now, rand].join)
  end
end

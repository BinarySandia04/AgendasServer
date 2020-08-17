class Invitation < ApplicationRecord
  belongs_to :group
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipent, :class_name => 'User'

  # TODO: self.create???

  def self.get_by_id(id)
    Invitation.find_by_id(id)
  end
end

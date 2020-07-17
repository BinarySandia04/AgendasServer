class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group



  class << self
    def get_role(role_id)
      roles = {
          "0" => "Membre",
          "1" => "Administrador"
      }
      return roles[role_id.to_s]
    end
  end
end

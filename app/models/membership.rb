class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  class << self
    def get_role_string(role_id)
      roles = {
          "0" => "Membre",
          "1" => "Administrador",
          "2" => "Observador"
      }
      return roles[role_id.to_s]
    end
  end
end

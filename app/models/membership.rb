class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  class << self
    def get_role_string(role_id)
      roles[role_id.to_s]
    end

    def roles
      {
          "0" => "Membre",
          "1" => "Administrador",
          "2" => "Observador"
      }
    end

    def roles_list
      %w[Membre Administrador Observador]
    end
  end
end

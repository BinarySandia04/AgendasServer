class Group < ApplicationRecord
  has_many :tasks
  has_many :categories

  has_many :memberships
  has_many :users, through: :memberships

  has_many :invitations

  after_commit :flush_cache

  def flush_cache
    Rails.cache.delete('groups')
  end

  def self.invite(group, from, to)
    # Funció que envia una invitacio a un grup que l'envia un administrador d'un grup i la rep un usuari
    # Aquesta funcio crea el model de la invitacio i envia una notificació al receptor
    invite = Invitation.new()
    invite.group_id = group.id
    invite.sender_id = from.id
    invite.recipent_id = to.id

    if invite.save
      # Ok ara enviar notificacio
      notification = Notification.create(to, "T'han convidat a un grup!", from.username + " t'ha convidat al grup " + group.name + " i vol que hi formis part")
      notification.action = '/acceptinvite/' + invite.id.to_s
      notification.deny_action = '/denyinvite/' + invite.id.to_s

      notification.action_name = "Acceptar"
      notification.deny_action_name = "Ignorar"

      # Notification, denyAction
      notification.confirmable = true
      notification.save
    else
      # TODO: Testing, Pot explotar si enviem 2 a la mateixa persona?
    end
  end

  class << self
    def get_from_cache(code)
      Rails.cache.fetch('groups') {Group.find_by_code(code)}
    end

    def get_from_cache_id(id)
      Rails.cache.fetch('groups') {Group.find(id)}
    end

    def has_right_permissions(group, user, roles)
      if group.nil?
        return false
      end

      unless group.users.exists?(user.id)
        return false
      end

      userRole = user.get_role(group)
      roles.each do |role|
        if userRole == role
          return true
        end
      end

      return false
    end
  end
end

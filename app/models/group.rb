class Group < ApplicationRecord
  has_many :tasks

  has_many :memberships
  has_many :users, through: :memberships

  has_many :invitations

  after_commit :flush_cache

  def flush_cache
    Rails.cache.delete('groups')
  end

  class << self
    def get_from_cache(code)
      Rails.cache.fetch('groups') {Group.find_by_code(code)}
    end
  end
end

class Category < ApplicationRecord
  belongs_to :group
  has_many :tasks

  before_create :init

  def init
    self.accentcolor = Utils::Color.randomBright().toInt()
  end


end

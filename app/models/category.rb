class Category < ApplicationRecord
  belongs_to :group

  before_create :init

  def init
    self.accentcolor = Color.randomBright().toInt()
  end
end

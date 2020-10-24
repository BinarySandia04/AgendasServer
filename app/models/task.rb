class Task < ApplicationRecord
  belongs_to :group
  belongs_to :category
  belongs_to :user

  has_many :assigments

  has_one_attached :file

  def file_formatting
    return unless file.attached?
    if file.blob.byte_size > 15.megabytes
      file.purge
      return 'SIZE_ERROR'
    else
      return 'OK'
    end
  end
end

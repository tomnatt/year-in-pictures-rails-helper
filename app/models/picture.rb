# Picture model
class Picture < ApplicationRecord
  validates :user,
            :image_title,
            :caption,
            :description,
            :month,
            :year,
            :image, presence: true

  validates :month, inclusion: 1...12
  validates :year, numericality: { only_integer: true }

  after_initialize :default_values

  def default_values
    # Default to last month, taking care of January
    now = Date.current
    if now.month == 1
      self.month ||= 12
      self.year ||= now.year - 1
    else
      self.month ||= now.month - 1
      self.year ||= now.year
    end
  end
end

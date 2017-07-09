# Picture model
class Picture < ApplicationRecord
  validates :user,
            :image_title,
            :caption,
            :description,
            :month,
            :year,
            :image, presence: true

  validates :year, numericality: { only_integer: true }

  after_initialize :default_values

  def default_values
    # Default month to last month
    self.month ||= Date.current.month - 1
    self.year ||= Date.current.year
  end
end

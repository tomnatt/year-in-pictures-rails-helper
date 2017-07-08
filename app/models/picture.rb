# Picture model
class Picture < ApplicationRecord
  validates :user,
            :image_title,
            :caption,
            :description,
            :month,
            :year,
            :image, presence: true
end

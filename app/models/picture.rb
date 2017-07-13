# Picture model
class Picture < ApplicationRecord
  attr_reader :photographers

  validates :photographer,
            :image_title,
            :caption,
            :description,
            :month,
            :year,
            :alt,
            :image, presence: true

  validates :photographer, presence: true, if: proc { |p| p.photographer.in?(Picture.photographers) }
  validates :month, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :year, numericality: { only_integer: true }

  after_initialize :default_values
  before_validation :populate_image_file

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

  def populate_image_file
    self.image = "#{month.to_s.rjust(2, '0')}-#{photographer}.jpg"
  end

  def self.photographers
    %w[dad dan ed gareth gill
       hon iris kat kirsty lyns
       michael sean sheena teresa tom]
  end

  # Going to brute force this output until I find something nicer
  # to do the YAML (with nice formatting) and the line breaks
  # WARNING: syntax highlighting doesn't like this
  def yaml_output
    <<YAML
  -
    image: #{image}
    image_title:  "#{image_title}"
    caption: "#{caption}"
    description: #{description.inspect.gsub(/\\r\\n\\r\\n/, '<br ><br >')}
    alt: "#{alt}"
    month: #{Date::MONTHNAMES[month].downcase}
YAML
  end
end

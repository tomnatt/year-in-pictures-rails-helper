require 'date_service'

# Picture model
class Picture < ApplicationRecord
  attr_reader :photographers

  belongs_to :user

  validates :user,
            :image_title,
            :caption,
            :description,
            :month,
            :year,
            :alt,
            :image, presence: true

  validates :month, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :year, numericality: { only_integer: true }

  after_initialize :default_values
  before_validation :populate_image_file

  scope :sort_by_date_user, lambda {
    joins('left join users on pictures.user_id = users.id')
      .order(year: :desc)
      .order(month: :desc)
      .order('users.fullname asc')
  }

  scope :sorted_filtered_for_user, lambda { |user|
    sort_by_date_user.where(user_id: user.id)
  }

  def default_values
    self.month ||= DateService.define_last_month
    self.year ||= DateService.year_for_last_month
  end

  def populate_image_file(extension = 'jpg')
    # delete method is just in case
    person_name = user.fullname.gsub(' and ', '-').delete(' ').downcase
    self.image = "#{month.to_s.rjust(2, '0')}-#{person_name}.#{extension}"
  end

  # Placeholder picture, for display when a picture is missing
  def self.placeholder(photographer)
    picture = Picture.new
    picture.user = User.find_by_fullname_or_placeholder(photographer)
    picture.image_title = 'Placeholder'
    picture.caption = 'Placeholder'
    picture.description = 'Placeholder'
    picture.alt = 'Placeholder'
    picture.populate_image_file('png')

    picture
  end

  # Going to brute force this output until I find something nicer
  # to do the YAML (with nice formatting) and the line breaks
  # WARNING: syntax highlighting doesn't like this
  def yaml_output
    <<YAML
  -
    image: #{image}
    image_title: "#{image_title}"
    caption: "#{caption}"
    description: #{description.inspect.gsub(/\\r\\n\\r\\n/, '<br ><br >')}
    alt: "#{alt}"
    month: #{Date::MONTHNAMES[month].downcase}
YAML
  end
end

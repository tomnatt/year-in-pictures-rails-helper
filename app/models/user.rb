require 'date_service'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :pictures, dependent: :nullify

  validates :fullname, :role, presence: true
  validates :fullname, uniqueness: { case_sensitive: false }
  validates :role, inclusion: { in: :role }

  enum :role, { disabled: 0, user: 1, admin: 2 }
  after_initialize :set_default_role, if: :new_record?

  # Called by Devise to ensure current user is ok to authenticate
  def active_for_authentication?
    super && !disabled?
  end

  # Custom message for when account disabled
  def inactive_message
    'Account is disabled'
  end

  # Does this user already have a picture for last month?
  def picture_for_last_month?
    month = DateService.define_last_month
    year = DateService.year_for_last_month
    Picture.month_year_for_user_count(month, year, self).positive?
  end

  # Going to brute force this output until I find something nicer
  # to do the YAML (with nice formatting) and the line breaks
  # WARNING: syntax highlighting doesn't like this
  def yaml_output
    <<YAML
  -
    id: #{id}
    name: #{fullname}
YAML
  end

  def self.all_active
    # Role 0 is disabled
    User.where.not(role: 0)
  end

  def self.find_by_fullname_or_placeholder(fullname)
    user = User.find_by(fullname:)
    return user unless user.nil?

    User.new(email: 'nothing@example.com', fullname:)
  end

  private

  def set_default_role
    self.role ||= :user
  end
end

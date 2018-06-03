class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  has_many :pictures

  validates :fullname, :role, presence: true
  validates :fullname, uniqueness: { case_sensitive: false }
  validates :role, inclusion: { in: :role }

  enum role: %i[disabled user admin]
  after_initialize :set_default_role, if: :new_record?

  # Called by Devise to ensure current user is ok to authenticate
  def active_for_authentication?
    super && !disabled?
  end

  # Custom message for when account disabled
  def inactive_message
    'Account is disabled'
  end

  def self.all_active
    # Role 0 is disabled
    User.where.not(role: 0)
  end

  def self.find_by_fullname_or_placeholder(fullname)
    user = User.find_by(fullname: fullname)
    return user unless user.nil?
    User.new(email: 'nothing@example.com', fullname: fullname)
  end

  private

  def set_default_role
    self.role ||= :user
  end
end

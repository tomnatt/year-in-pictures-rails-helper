class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pictures

  validates :fullname, :role, presence: true
  validates :fullname, uniqueness: { case_sensitive: false }
  validates :role, inclusion: { in: :role }

  enum role: %i[disabled user admin]
  after_initialize :set_default_role, if: :new_record?

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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pictures

  validates :fullname, presence: true

  def self.find_by_fullname_or_placeholder(fullname)
    user = User.find_by(fullname: fullname)
    return user unless user.nil?
    User.new(email: 'nothing@example.com', fullname: fullname)
  end
end

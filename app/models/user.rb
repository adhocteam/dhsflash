class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    :confirmable,
    :lockable,
    :timeoutable
  )

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, length: { maximum: 30 }, uniqueness: true

  def name
    "#{first_name} #{last_name}"
  end
end

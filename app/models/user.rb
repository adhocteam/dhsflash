class User < ApplicationRecord
  rolify

  has_many :created_kudos, as: :creator
  has_many :recipient_kudos, as: :recipient

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
    :timeoutable,
    :invitable
  )

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :title, presence: true

  scope :confirmed, -> { where.not(confirmed_at: nil) }

  def name
    "#{first_name} #{last_name}"
  end

  def initials
    "#{first_name[0]}#{last_name[0]}".upcase
  end

  def should_get_notification?(type)
    if notification_frequency == 'none'
      false
    elsif notification_frequency == 'all'
      true
    elsif notification_frequency == 'mentions' && type == :new_kudo
      true
    else
      false
    end
  end

  def active_for_authentication?
    super && is_enabled?
  end

  def toggle!
    toggle(:is_enabled)
    save!
  end
end

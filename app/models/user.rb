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

  after_create :attach_to_kudos

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

  def attach_to_kudos
    Kudo.where(recipient_id: nil, recipient_email: email).each do |kudo|
      kudo.update_attributes(
        recipient_id: id,
        recipient_email: nil
      )
      update_attribute(kudos_received: kudos_received + 1)
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

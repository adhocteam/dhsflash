class Kudo < ApplicationRecord
  belongs_to :creator, class_name: User
  belongs_to :recipient, class_name: User

  validates :message, presence: true
  validate :cannot_kudo_onesself

  protected

  def cannot_kudo_onesself
    errors.add(:recipient_id, 'cannot be the same as the creator') if creator_id == recipient_id
  end
end

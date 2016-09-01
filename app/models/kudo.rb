class Kudo < ApplicationRecord
  belongs_to :creator, class_name: User
  belongs_to :recipient, class_name: User
  has_many :thumbs_ups

  validates :message, presence: true
  validate :cannot_kudo_onesself

  after_create :notify_recipient

  protected

  def notify_recipient
    if recipient.should_get_notification?(:new_kudo)
      KudoMailer.received_kudo_email(self).deliver
    end
  end

  def cannot_kudo_onesself
    errors.add(:recipient_id, 'cannot be the same as the creator') if creator_id == recipient_id
  end
end

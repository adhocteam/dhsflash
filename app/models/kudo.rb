class Kudo < ApplicationRecord

  CATEGORIES = %w(
    Teamwork
    Improvement
    Delivery
    Experiment
  ).freeze

  mount_uploader :attachment, AttachmentUploader

  belongs_to :creator, class_name: User
  belongs_to :recipient, class_name: User

  validates :category, presence: true
  validates :message, presence: true
  validate :cannot_kudo_onesself

  after_create :update_user_counts
  after_create :notify_recipient

  protected

  def update_user_counts
    creator.update_attributes(kudos_sent: creator.kudos_sent + 1)
    recipient.update_attributes(kudos_received: recipient.kudos_received + 1)
  end

  def notify_recipient
    if recipient.should_get_notification?(:new_kudo)
      KudoMailer.received_kudo_email(self).deliver
    end
  end

  def cannot_kudo_onesself
    errors.add(:recipient_id, 'cannot be the same as the creator') if creator_id == recipient_id
  end
end

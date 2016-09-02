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
  validate :only_one_per_day_per_person

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

  def only_one_per_day_per_person
    any = Kudo
      .where(creator_id: creator_id, recipient_id: recipient_id)
      .where('created_at > ?', Date.today)
      .where.not(id: id)
      .any?
    if any
      errors.add(:recipient_id, 'can only receive one point from you per day')
    end
  end
end

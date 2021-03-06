class Kudo < ApplicationRecord

  CATEGORIES = %w(
    Teamwork
    Improvement
    Delivery
    Experiment
  ).freeze

  mount_uploader :attachment, AttachmentUploader

  belongs_to :creator, class_name: User
  belongs_to :recipient, class_name: User, optional: true

  validates :category, presence: true
  validates :message, presence: true
  validate :cannot_kudo_onesself
  validate :only_one_per_day_per_person
  validate :either_recipient_or_recipient_email
  before_validation :see_if_recipient_exists, on: :create
  validate :cannot_kudo_disabled_user

  after_create :update_user_counts
  after_create :notify_recipient

  protected

  def see_if_recipient_exists
    if recipient_email && !recipient
      if User.where(email: recipient_email).any?
        self.recipient_id = User.where(email: recipient_email).first.id
        self.recipient_email = nil
      end
    end
  end

  def update_user_counts
    creator.update_attributes(kudos_sent: creator.kudos_sent + 1)
    if recipient
      recipient.update_attributes(kudos_received: recipient.kudos_received + 1)
    end
  end

  def notify_recipient
    if recipient.nil? && recipient_email
      User.invite!(email: recipient_email)
    elsif recipient.try(:should_get_notification?, :new_kudo)
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

  def either_recipient_or_recipient_email
    if recipient_id.nil? && recipient_email.blank?
      errors.add(:recipient_id, 'is required')
    end
  end

  def cannot_kudo_disabled_user
    # errors.add(:recipient_id, 'is disabled user') if recipient && !User.where(id: recipient_id).first.is_enabled?
  end
end

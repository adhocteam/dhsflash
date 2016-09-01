class ThumbsUp < ApplicationRecord
  belongs_to :user
  belongs_to :kudo

  validate :only_one_per_user

  after_create :notify_recipient

  protected

  def only_one_per_user
    if ThumbsUp.where(user_id: user_id, kudo_id: kudo_id).where.not(id: id).any?
      errors.add(:user, 'can only give one thumbs up')
    end
  end

  def notify_recipient
    if kudo.creator.should_get_notification?(:new_thumbs_up_creator)
      KudoMailer.thumbs_up_creator_email(self).deliver
    end

    if kudo.recipient.should_get_notification?(:new_thumbs_up_recipient)
      KudoMailer.thumbs_up_recipient_email(self).deliver
    end
  end
end

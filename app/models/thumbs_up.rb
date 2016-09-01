class ThumbsUp < ApplicationRecord
  belongs_to :user
  belongs_to :kudo

  after_create :notify_recipient

  def notify_recipient
    if kudo.creator.should_get_notification?(:new_thumbs_up_creator)
      KudoMailer.thumbs_up_creator_email(self).deliver
    end

    if kudo.recipient.should_get_notification?(:new_thumbs_up_recipient)
      KudoMailer.thumbs_up_recipient_email(self).deliver
    end
  end
end

class KudoMailer < ApplicationMailer
  def received_kudo_email(kudo)
    @kudo = kudo
    @user = kudo.recipient
    mail(to: @user.email, subject: "You received a new kudo from #{kudo.creator.username}")
  end

  def thumbs_up_creator_email(thumb)
    @thumb = thumb
    recipient = thumb.kudo.recipient
    mail(to: @thumb.kudo.creator.email, subject: "Your kudo to #{recipient.username} received a thumbs up from #{thumb.user.username}")
  end

  def thumbs_up_recipient_email(thumb)
    @thumb = thumb
    creator = thumb.kudo.creator
    mail(to: @thumb.kudo.recipient.email, subject: "Your kudo from #{creator.username} received a thumbs up from #{thumb.user.username}")
  end
end

class KudoMailer < ApplicationMailer
  def received_kudo_email(kudo)
    @kudo = kudo
    @user = kudo.recipient
    mail(to: @user.email, subject: "You received a new kudo from #{kudo.creator.username}")
  end
end

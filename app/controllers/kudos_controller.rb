class KudosController < ApplicationController
  before_action :authenticate_user!

  def create
    @kudo = Kudo.create(kudo_params)
    if @kudo.save
      render partial: 'shared/kudo_card', locals: { kudo: @kudo }
    else
      render partial: 'shared/error_messages_for', locals: { object: @kudo }, status: 400
    end
  end

  protected

  def kudo_params
    ps = params.require(:kudo).permit(
      :message,
      :recipient_id
    )
    ps[:creator_id] = current_user.id
    ps
  end
end

class KudosController < ApplicationController
  before_action :authenticate_user!

  def index
    kudos = Kudo.order(created_at: :desc)
    if params[:filter] == 'about_me'
      kudos = kudos.where(recipient_id: current_user.id)
    elsif params[:filter] == 'from_me'
      kudos = kudos.where(creator_id: current_user.id)
    end
    render partial: 'shared/kudos_stream', locals: { kudos: kudos }
  end

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
      :recipient_id,
      :recipient_email,
      :category,
      :attachment,
      :attachment_cache
    )
    ps[:creator_id] = current_user.id
    ps
  end
end

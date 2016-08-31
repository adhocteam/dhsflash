class KudosController < ApplicationController
  before_action :authenticate_user!

  def create
    @kudo = Kudo.create(kudo_params)
    if @kudo.save
      redirect_to dashboard_path
    else
      @kudos = Kudo.all
      render 'dashboard/show'
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

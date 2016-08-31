class KudosController < ApplicationController
  before_action :authenticate_user!

  def create
    @kudo = Kudo.create(kudo_params)
    if @kudo.save
      redirect_to dashboard_path
    else
      render 'home/show'
    end
  end

  protected

  def kudo_params
    ps = params.require(:kudo).permit(
      :message
    )
    ps[:user_id] = current_user.id
    ps
  end
end

class ThumbsUpsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_kudo

  def create
    thumb = @kudo.thumbs_ups.create(user: current_user)
    if thumb.valid?
      render partial: 'shared/kudo_thumbs_up', locals: { kudo: @kudo }
    else
      render json: thumb.errors, status: 400
    end
  end

  protected

  def find_kudo
    @kudo = Kudo.find(params[:kudo_id])
  end
end

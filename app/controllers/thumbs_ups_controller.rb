class ThumbsUpsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_kudo

  def create

  end

  protected

  def find_kudo
    @kudo = Kudo.find(params[:kudo_id])
  end
end

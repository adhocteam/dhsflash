class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @kudos = Kudo.order(created_at: :desc)
  end
end

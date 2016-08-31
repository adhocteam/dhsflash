class DashboardController < ApplicationController
  def show
    @kudos = Kudo.order(created_at: :desc)
  end
end

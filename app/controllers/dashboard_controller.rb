class DashboardController < ApplicationController
  before_action :authenticate_user!
  after_action :mark_greeting_seen

  def show
    @kudos = Kudo.appropriate.order(created_at: :desc)
  end

  protected

  def mark_greeting_seen
    session[:dashboard_greeting_seen] = true
  end
end

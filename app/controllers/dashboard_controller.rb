class DashboardController < ApplicationController
  before_action :authenticate_user!
  after_action :mark_greeting_seen

  def show
    @kudos = Kudo.order(created_at: :desc)
    @received_leaders = User.order(kudos_received: :desc).limit(4)
    @sent_leaders = User.order(kudos_sent: :desc).limit(4)
  end

  protected

  def mark_greeting_seen
    session[:dashboard_greeting_seen] = true
  end
end

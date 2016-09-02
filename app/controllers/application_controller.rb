class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :first_name,
        :last_name,
        :username,
        :title
      ]
    )
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [
        :first_name,
        :last_name,
        :username,
        :title,
        :notification_frequency,
        :notification_method,
        :mobile_number
      ]
    )
    devise_parameter_sanitizer.permit(
      :accept_invitation,
      keys: [
        :first_name,
        :last_name,
        :username,
        :title,
        :password,
        :password_confirmation,
        :invitation_token
      ]
    )
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def require_admin
    if !current_user.try(:has_role?, :admin)
      flash[:alert] = 'Only admins can view that page'
      redirect_to dashboard_path
    end
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end
end

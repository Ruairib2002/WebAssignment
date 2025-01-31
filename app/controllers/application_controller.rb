class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :logout_inactive_users  # Commented out to disable auto-logout

  def after_sign_in_path_for(resource)
    resource.role.role_name == "admin" ? admin_panel_path : root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
  end

  # def logout_inactive_users  # Commented out to disable inactivity logout check
  #   if current_user && session[:last_seen_at] && session[:last_seen_at] < 30.minutes.ago
  #     sign_out current_user
  #     redirect_to new_user_session_path, alert: 'You have been logged out due to inactivity.'
  #   end
  #   session[:last_seen_at] = Time.current if current_user
  # end
end

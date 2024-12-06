class AdminController < ApplicationController
  before_action :authenticate_user!  # Ensures user is logged in
  before_action :authorize_admin  # Checks if the user has admin rights

  def panel
    # You can add any specific logic for the admin panel here, like loading statistics
  end

  private

  # This method checks if the current user has an 'admin' role. If not, they are redirected to the root path.
  def authorize_admin
    unless current_user.role.role_name == "admin"
      redirect_to root_path, alert: "Access Denied: You do not have permission to access this page."
    end
  end
end

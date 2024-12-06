class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def panel
  end

  private

  def authorize_admin
    unless current_user.role.role_name == "admin"
      redirect_to root_path, alert: "Access Denied: You do not have permission to access this page."
    end
  end
end

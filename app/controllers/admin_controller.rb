class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin_password, only: :panel

  def panel
  end

  def new_password
  end

  def authenticate_password
    if params[:admin_password] == Rails.application.credentials.admin_password
      session[:admin_authenticated] = true
      redirect_to admin_panel_path, notice: "Access granted."
    else
      flash.now[:alert] = "Incorrect password. Try again."
      render :new_password
    end
  end

  def manage_roles
    @users = User.all
  end

  def update_role
    user = User.find(params[:id])
    user.update(role_id: params[:role_id])
    redirect_to admin_manage_roles_path, notice: "Role updated successfully."
  end

  private

  def verify_admin_password
    unless session[:admin_authenticated]
      redirect_to new_admin_password_path
    end
  end
end

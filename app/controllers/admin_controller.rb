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
    user = User.find_by(id: params[:id])
    role = Role.find_by(id: params[:user][:role_id])

    if user.nil?
      redirect_to admin_manage_roles_path, alert: "User not found."
      return
    end

    if role.nil?
      redirect_to admin_manage_roles_path, alert: "Invalid role selected."
      return
    end

    if user.update(role_id: role.id)
      redirect_to admin_manage_roles_path, notice: "Role updated successfully."
    else
      redirect_to admin_manage_roles_path, alert: "Failed to update role: #{user.errors.full_messages.join(', ')}."
    end
  end

  def users_index
    @users = User.all
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def update_user
    @user = User.find(params[:id])

    password_params = user_params[:password].present? ? { password: user_params[:password], password_confirmation: user_params[:password_confirmation] } : {}

    if @user.update(user_params.except(:password, :password_confirmation).merge(password_params))
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render :edit_user
    end
  end

  def groups_index
    @groups = Group.all
  end

  def edit_group
    @group = Group.find(params[:id])
  end

  def update_group
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to admin_groups_path, notice: "Group updated successfully."
    else
      render :edit_group
    end
  end

  def issues
    @issues = Issue.all
  end

  def resolve_issue
    @issue = Issue.find(params[:id])
    if @issue.update(active: false)
      redirect_to admin_issues_path, notice: "Issue marked as resolved."
    else
      redirect_to admin_issues_path, alert: "Failed to resolve the issue."
    end
  end

  def resolve_all_issues
    Issue.update_all(active: false)
    redirect_to admin_issues_path, notice: "All issues resolved."
  end

  private

  def verify_admin_password
    unless session[:admin_authenticated]
      redirect_to new_admin_password_path
    end
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :role_id)
  end

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end

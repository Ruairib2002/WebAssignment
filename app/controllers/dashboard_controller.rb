class DashboardController < ApplicationController
  def index
    if current_user.role.role_name == 'admin'
      @groups = Group.all
      @users = User.all
    elsif current_user.role.role_name == 'teacher'
      @groups = current_user.groups
    else
      @groups = current_user.groups
    end
  end
end

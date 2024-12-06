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

    @sent_messages = Message.where(posted_by: current_user.id)
    @received_messages = Message.where(recipient_id: current_user.id)
  end
end

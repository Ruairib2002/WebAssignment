class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @messages = @group.messages.order(created_at: :desc)
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      UserGroup.create(user: current_user, group: @group) # Add current_user to the group
      redirect_to @group, notice: "Group created successfully."
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end

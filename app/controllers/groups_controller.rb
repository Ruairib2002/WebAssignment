class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @messages = @group.messages.order(created_at: :desc)
    @students = User.where(role: 'student') # List of all students
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

  def add_student
    group = Group.find(params[:group_id])
    student = User.find(params[:student_id])
    group.users << student unless group.users.include?(student)
    redirect_to group, notice: "Student added successfully."
  end

  def remove_student
    group = Group.find(params[:group_id])
    student = User.find(params[:student_id])
    group.users.delete(student)
    redirect_to group, notice: "Student removed successfully."
  end

  def search
    if params[:query].present?
      @groups = Group.where('name LIKE ?', "%#{params[:query]}%")
    else
      @groups = Group.all
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end

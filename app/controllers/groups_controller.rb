class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_teacher_role, only: [:add_student, :remove_student, :upload_file, :assign_marks]

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @messages = @group.messages.order(created_at: :desc)
    student_role = Role.find_by(role_name: 'student')
    @students = User.where(role_id: student_role.id).where.not(id: @group.user_ids)
    @assignments = @group.assignments
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)
    @group.teacher_id = current_user.id
    if @group.save
      UserGroup.create(user: current_user, group: @group)
      redirect_to groups_path, notice: "Group created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def add_student
    group = Group.find(params[:id])
    student = User.find(params[:student_id])

    unless group.users.include?(student)
      group.users << student
      redirect_to group, notice: "Student added successfully."
    else
      redirect_to group, alert: "Student is already in the group."
    end
  end

  def remove_student
    group = Group.find(params[:id])
    student = User.find(params[:student_id])
    group.users.delete(student)
    redirect_to group, notice: "Student removed successfully."
  end

  def upload_file
    @group = Group.find(params[:id])
    if params[:file].present?
      @group.files.attach(params[:file])
      redirect_to @group, notice: "File uploaded successfully."
    else
      redirect_to @group, alert: "Please select a file to upload."
    end
  end

  def assign_marks
    @group = Group.find(params[:id])
    student = User.find(params[:student_id])
    mark = params[:marks].to_f

    assignment = Assignment.find(params[:assignment_id])
    submission = Submission.find_or_create_by(assignment: assignment, user: student)

    submission.assign_marks(student.id, mark)

    redirect_to @group, notice: "Marks assigned successfully to #{student.full_name}."
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
    params.require(:group).permit(:name, :description, files: [])
  end

  def check_teacher_role
    redirect_to root_path, alert: "You do not have permission to perform this action." unless current_user.role.role_name == "teacher"
  end
end

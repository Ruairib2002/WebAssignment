class AssignmentsController < ApplicationController
  before_action :set_group

  def new
    @assignment = @group.assignments.new
  end

  def create
    @assignment = @group.assignments.build(assignment_params)
    if @assignment.save
      redirect_to @group, notice: "Assignment created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def assign_marks
    @assignment = @group.assignments.find(params[:assignment_id])
    student = User.find(params[:student_id])
    marks = params[:marks].to_f

    submission = Submission.find_or_create_by(assignment: @assignment, user: student)
    submission.assign_marks(student.id, marks)

    redirect_to @group, notice: "Marks assigned to #{student.full_name}."
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def assignment_params
    params.require(:assignment).permit(:title, :description, :due_date, files: [])
  end
end

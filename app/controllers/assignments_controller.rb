class AssignmentsController < ApplicationController
  before_action :set_group

  def assign_marks
    user = User.find(params[:user_id])
    mark = params[:marks]

    assignment = @group.assignments.find(params[:assignment_id])
    assignment.assign_marks(user.id, mark)

    redirect_to group_path(@group), notice: 'Marks assigned successfully.'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end

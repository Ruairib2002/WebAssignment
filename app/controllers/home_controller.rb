class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @assignments = Assignment.joins(group: :users)
                             .where(groups: { id: current_user.group_ids })
                             .where("assignments.due_date >= ?", Time.current)
                             .distinct
  end
end

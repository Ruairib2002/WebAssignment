class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @assignments = current_user.groups.joins(:assignments).where("assignments.due_date >= ?", Time.current).distinct
  end
end

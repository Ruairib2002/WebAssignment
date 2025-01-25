class GpsController < ApplicationController
  def index
    # Render the GPS map page with existing issues
    @issues = Issue.all
  end

  def report_issue
    # Create a new issue report
    @issue = Issue.new(issue_params)
    if @issue.save
      redirect_to gps_path, notice: 'Issue reported successfully!'
    else
      redirect_to gps_path, alert: 'Error reporting issue!'
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:latitude, :longitude, :description, :category)
  end
end

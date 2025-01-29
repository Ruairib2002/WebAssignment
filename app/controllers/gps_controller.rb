class GpsController < ApplicationController
  def index
    @issues = Issue.select(:latitude, :longitude, :description, :category)

    # Debugging log to verify issues are fetched correctly
    Rails.logger.debug "Issues: #{@issues.inspect}"
  end

  def report_issue
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

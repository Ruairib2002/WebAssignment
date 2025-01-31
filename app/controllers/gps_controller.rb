class GpsController < ApplicationController
  def index
    @places = Place.all
    @issues = Issue.select(:latitude, :longitude, :description, :category)
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

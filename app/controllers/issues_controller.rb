class IssuesController < ApplicationController
  def index
    # Fetch issues that are active
    @issues = Issue.where(active: true)
  end

  def create
    # Create a new issue with the provided parameters
    @issue = Issue.new(issue_params)

    if @issue.save
      # If saved successfully, redirect to the issues index with a success notice
      redirect_to issues_path, notice: 'Issue successfully added.'
    else
      # If an error occurs, re-render the index page with an alert
      render :index, alert: 'Error adding issue.'
    end
  end

  private

  # Strong parameters for issue
  def issue_params
    params.require(:issue).permit(:latitude, :longitude, :issue_type)
  end
end

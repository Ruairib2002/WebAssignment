class IssuesController < ApplicationController
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  def index
    # Fetch issues that are active
    @issues = Issue.where(active: true)
  end

  def create
    # Create a new issue with the provided parameters
    @issue = Issue.new(issue_params)

    if @issue.save
      # If saved successfully, respond with a JSON response including issue details
      render json: { success: true, issue: @issue }
    else
      # If an error occurs, render a JSON response with failure status and error messages
      render json: { success: false, errors: @issue.errors.full_messages }
    end
  end

  private

  # Strong parameters for issue
  def issue_params
    params.require(:issue).permit(:latitude, :longitude, :issue_type)
  end
end

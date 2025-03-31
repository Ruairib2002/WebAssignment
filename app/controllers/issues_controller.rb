class IssuesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      render json: { success: true, issue: @issue }
    else
      render json: { success: false, errors: @issue.errors.full_messages }
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:issue_type, :latitude, :longitude)
  end
end

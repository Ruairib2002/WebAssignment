class IssuesController < ApplicationController
  def index
    # Delete expired issues automatically on each page load
    Issue.where("expired_at <= ?", Time.now).destroy_all

    @issues = Issue.all
  end

  def new
    @issue = Issue.new(latitude: params[:latitude], longitude: params[:longitude])
  end

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      # Calculate the expiration time after the issue is saved
      if @issue.estimated_time != "indefinite" && @issue.estimated_time.present?
        @issue.update(expired_at: @issue.created_at + @issue.estimated_time.to_f.hours)
      else
        @issue.update(expired_at: nil) # No expiration time for indefinite
      end

      redirect_to issues_path, notice: 'Issue created successfully.'
    else
      render :new
    end
  end


  def active
    @issues = Issue.where(active: true)
    render json: @issues
  end

  # Action to display all issues in a table and resolve them
  def resolve_all
    @issues = Issue.all
  end

  # Action to mark a single issue as resolved
  def resolve_issue
    @issue = Issue.find(params[:id])

    # Mark the issue as inactive
    @issue.update(active: false)

    # Delete the issue after marking as resolved
    @issue.destroy

    redirect_to resolve_all_issues_path, notice: 'Issue marked as resolved and deleted.'
  rescue => e
    redirect_to resolve_all_issues_path, alert: "Failed to resolve issue: #{e.message}"
  end

  private

  def issue_params
    params.require(:issue).permit(:description, :category, :latitude, :longitude, :estimated_time, :active)
  end
end

class IssuesController < ApplicationController
  before_action :set_issue, only: [:resolve_issue]

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

  def resolve_all
    @issues = Issue.all
  end

  # Action to mark a single issue as resolved
  def resolve_issue
    @user = current_user # Assuming you have a current_user helper method to get the logged-in user.

    # Check if the user has already voted for this issue
    existing_vote = @issue.issue_votes.find_by(user_id: @user.id)

    if existing_vote
      # If the user has already voted, show the "Already voted" message
      redirect_to resolve_all_issues_path, alert: "Already voted for this issue."  # Fix here to use the correct path
    else
      # If the user has not voted, create a new vote
      vote = @issue.issue_votes.create(user: @user, resolved: true)

      if vote.persisted?
        # Check if the issue has enough resolved votes (2 votes in this case, adjust to your needs)
        if @issue.issue_votes.where(resolved: true).count >= 2
          # Delete associated votes before deleting the issue
          @issue.issue_votes.destroy_all  # Remove all related votes

          @issue.update(active: false) # Mark the issue as resolved
          @issue.destroy # Delete the issue after it is resolved
          message = "Issue has been marked as resolved and deleted."
        else
          message = "Your vote has been added. We need more votes to resolve the issue."
        end
        redirect_to resolve_all_issues_path, notice: message  # Fix here to use the correct path
      else
        redirect_to resolve_all_issues_path, alert: "There was an issue adding your vote. Please try again."  # Fix here to use the correct path
      end
    end
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def issue_params
    params.require(:issue).permit(:description, :category, :latitude, :longitude, :estimated_time, :active)
  end
end

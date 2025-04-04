class IssuesController < ApplicationController
  before_action :set_issue, only: [:resolve_issue]

  def index
    Issue.where("expired_at <= ?", Time.now).destroy_all
    @issues = Issue.all
  end

  def new
    @issue = Issue.new(latitude: params[:latitude], longitude: params[:longitude])
  end

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      if @issue.estimated_time != "indefinite" && @issue.estimated_time.present?
        @issue.update(expired_at: @issue.created_at + @issue.estimated_time.to_f.hours)
      else
        @issue.update(expired_at: nil)
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

  def resolve_issue
    @user = current_user
    existing_vote = @issue.issue_votes.find_by(user_id: @user.id)

    if existing_vote
      redirect_to resolve_all_issues_path, alert: "Already voted for this issue."
    else
      vote = @issue.issue_votes.create(user: @user, resolved: true)

      if vote.persisted?
        if @issue.issue_votes.where(resolved: true).count >= 2
          @issue.issue_votes.destroy_all
          @issue.update(active: false)
          @issue.destroy
          message = "Issue has been marked as resolved and deleted."
        else
          message = "Your vote has been added. We need more votes to resolve the issue."
        end
        redirect_to resolve_all_issues_path, notice: message
      else
        redirect_to resolve_all_issues_path, alert: "There was an issue adding your vote. Please try again."
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

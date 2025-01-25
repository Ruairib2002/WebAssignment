class IssuesController < ApplicationController
  def index
    @issues = Issue.all
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    if @issue.save
      redirect_to issues_path, notice: 'Issue created successfully!'
    else
      render :new, alert: 'Error creating issue!'
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:latitude, :longitude, :description, :category)
  end
end

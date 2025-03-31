class IssuesController < ApplicationController
  def index
    @issues = Issue.all
  end

  def new
    @issue = Issue.new(latitude: params[:latitude], longitude: params[:longitude])
  end

  def create
    @issue = Issue.new(issue_params)
    if @issue.save
      redirect_to issues_path, notice: 'Issue created successfully.'
    else
      render :new
    end
  end

  def active
    @issues = Issue.where(active: true)
    render json: @issues
  end

  private

  def issue_params
    params.require(:issue).permit(:description, :category, :latitude, :longitude)
  end
end

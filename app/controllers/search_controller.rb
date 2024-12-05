class SearchController < ApplicationController
  def index
    if params[:query].present?
      # Search for students by full_name and groups by name
      @students = User.where("full_name LIKE ?", "%#{params[:query]}%")
      @groups = Group.where("name LIKE ?", "%#{params[:query]}%")
    else
      @students = []
      @groups = []
    end
  end
end

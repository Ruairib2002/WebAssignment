class SearchController < ApplicationController
  def index
    if params[:query].present?
      @students = User.where("full_name LIKE ?", "%#{params[:query]}%")
      @groups = Group.where("name LIKE ?", "%#{params[:query]}%")
    else
      @students = []
      @groups = []
    end
  end
end

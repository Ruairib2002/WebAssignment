class HomeController < ApplicationController
  # Enforce authentication for the HomeController
  before_action :authenticate_user!  # Ensures the user is authenticated before accessing any actions in this controller

  # The index action that will render the home page
  def index
    # Any logic you want to run when accessing the home page can go here
  end
end

class GpsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:save_place]
  def index
    @places = Place.order(:name) 
  end

  # New route page
  def new_route
    @places = Place.order(:name)  # Sorted alphabetically by name
  end

  # Save a new place (from user adding a marker)
  def save_place
    place_data = JSON.parse(request.body.read)
    new_place = Place.create(
      name: place_data["name"],
      latitude: place_data["latitude"],
      longitude: place_data["longitude"]
    )

    if new_place.save
      render json: { success: true }
    else
      render json: { success: false, error: new_place.errors.full_messages }
    end
  end

  # Fetch all saved places as JSON (sorted alphabetically by name)
  def saved_places
    places = Place.order(:name).select(:id, :name, :latitude, :longitude)  # Sorted alphabetically by name
    render json: places
  end

  # Show details of a specific place
  def show
    place = Place.find(params[:id])
    render json: { latitude: place.latitude, longitude: place.longitude }
  end
end

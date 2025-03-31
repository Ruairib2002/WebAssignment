class GpsController < ApplicationController
  # Show a list of places (can be fetched via JSON in front-end)
  def index
    @places = Place.order(:name)
    render json: @places  # Send places as JSON to be used in the map
  end

  # New route page
  def new_route
    @places = Place.order(:name)
  end

  # Save new place (for reporting issues)
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

  # Show details of a specific place
  def show
    place = Place.find(params[:id])
    render json: { latitude: place.latitude, longitude: place.longitude }
  end
end

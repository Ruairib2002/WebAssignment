class GpsController < ApplicationController
  def index
    @places = Place.order(:name)
  end

  def new_route
    @places = Place.order(:name)
  end

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
end

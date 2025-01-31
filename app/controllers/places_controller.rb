class PlacesController < ApplicationController
  def show
    @place = Place.find(params[:id])
    render json: { latitude: @place.latitude, longitude: @place.longitude, name: @place.name }
  end
end

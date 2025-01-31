class PlacesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    if params[:places].present?
      created_places = params[:places].map do |place|
        Place.create(place.permit(:name, :latitude, :longitude))
      end
      render json: created_places, status: :created
    elsif params[:place].present?
      @place = Place.new(place_params)
      if @place.save
        render json: @place, status: :created
      else
        render json: @place.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "No place data provided" }, status: :bad_request
    end
  end

  def show
    @place = Place.find(params[:id])
    render json: @place
  end

  private

  def place_params
    params.require(:place).permit(:name, :latitude, :longitude)
  end
end

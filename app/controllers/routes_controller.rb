class RoutesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @routes = Route.all
  end

  def create
    @route = Route.new(route_params)

    if @route.save
      render json: { message: 'Route saved successfully!', route: @route }, status: :created
    else
      render json: { error: 'Failed to save route.' }, status: :unprocessable_entity
    end
  end

  private

  def route_params
    params.require(:route).permit(:from_lat, :from_lng, :to_lat, :to_lng, :name)
  end
end

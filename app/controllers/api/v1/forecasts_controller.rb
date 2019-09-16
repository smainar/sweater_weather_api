class Api::V1::ForecastsController < ApplicationController
  def show
    weather = ForecastFacade.new(params[:location])
    render json: ForecastSerializer.new(weather)
  end
end
# Pass location to Dark Sky's API, to return forecast
# Extract location - longitude & latitude coordinates
# Take raw forecast data and format through serializer

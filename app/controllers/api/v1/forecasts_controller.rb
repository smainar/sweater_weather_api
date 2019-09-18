class Api::V1::ForecastsController < ApplicationController
  def show
    weather = ForecastFacade.new(params[:location])
    render json: ForecastSerializer.new(weather)
  end
end

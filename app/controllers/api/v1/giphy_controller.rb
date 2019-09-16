class Api::V1::GiphyController < ApplicationController
  def index
    weather = GiphyFacade.new(params[:location])
    render json: GiphySerializer.new(weather)
  end
end
# Pass weather data from Dark Sky's API, to return animated GIFs
# Take raw giphy data and format through serializer

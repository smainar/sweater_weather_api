class Api::V1::GiphyController < ApplicationController
  def index
    # location = GiphyFacade.new(params[:location])
    # render json: GiphySerializer.new(location).get_giphy
    render json = GiphyFacade.new(params[:location]).get_giphy
  end
end
# Pass weather data from Dark Sky's API, to return animated GIFs
# Take raw giphy data and format through serializer

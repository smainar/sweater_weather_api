class Api::V1::BackgroundsController < ApplicationController
  def show
    background_facade = BackgroundFacade.new(params[:location]).get_image
    render json: BackgroundSerializer.new(background_facade)
  end
end

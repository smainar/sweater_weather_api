class Api::V1::AntipodesController < ApplicationController
  def show
    antipodes_facade = AntipodesFacade.new(params[:loc])
    require "pry"; binding.pry
    render json: AntipodesSerializer.new(antipodes_facade.get_forecast)
  end
end

# PROCESS:
# Map it out before I make it work
#
# Dream drive:
#   What do I want - write it down before thinking what goes it to it
#
# What goes in - parameters --> city location
#
# What goes out - formatted JSON string according to retake spec:
# Array:
#   Must return with key value pairs containing:
#     location name -- from Google Geocode
#     forecast:
#       summary & current temp -- from Darksky API
#     search location -- from Google Geocode
#
# RESPONSE:
# {
#     "data": [
#         {
#             "id": "1",
#             "type": "antipode",
#             "attributes": {
#                 "location_name": "Antipode City Name",
#                 "forecast": {
#                     "summary": "Mostly Cloudy,
#                     "current_temperature": "72",
#                                 },
#             "search_location": "Hong Kong"
#             }
#         }
#     ]
# }

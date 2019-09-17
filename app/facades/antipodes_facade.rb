class AntipodesFacade
  def initialize(location)
    @location = location
  end

  def get_forecast
    # Steps to take:

    # Pass city name to Geocode Service to get lat & long
    geocode_service = GoogleGeocodeService.new(@location)
    # This method retrieves the coordinates for search location
    coordinates = geocode_service.google_geocode_query_coordinates

    # Pass coordinates to AntipodesService
    #   This requires me to make an AntipodesService in order to make Faraday call & get response
    #     Must initialize AntipodesService with what I want to pass, which is coordinates
    antipodes_service = AntipodesService.new(coordinates)
    # Pass in coordinates from GeocodeService that returns antipode coordinates

    # Once I get coordinates from AntipodeService, pass those coordinates back to GeocodeService
    #  this will return name of antipode city, needed for response

    coordinates = geocode_service.google_geocode_query_coordinates

    # Ultimately, I want the hash to have:
    # summary & current_temp from Darksky API
    # name of search location from Google Geocode API
    # Must make make AntipodeService for API call / response to get lat & long coordinates

    # To retrieve the antipode's name use something like Google's reverse geocoding

    darksky_service = DarkskyService.new(coordinates)

    # query_string is icon from Darksky API

    # Dream Driving:
    darksky_service.darksky_current_summary_data.map do |summary_and_time|
      coordinates = antipode_service.get_coordinates(query_string)
      antipode_city =
      search_location =
      SomePOROtbd.new(summary_and_temp, antipode_city, search_location)
    end

    antipodes_service = AntipodesService.new(coordinates)

    # list of POROS
    raw_json_hash_data.map do |data|
      SomePOROtbd.new(data)
    end
  end
end

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

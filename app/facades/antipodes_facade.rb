class AntipodesFacade
  def initialize(location)
    @location = location
  end

  def get_forecast
    geocode_service = GoogleGeocodeService.new(@location)
    coordinates = geocode_service.google_geocode_query_coordinates

    # Ultimately, I want the hash to have:
    # summary & current_temp from Darksky API
    # name of search location from Google Geocode API
    # Must make make AntipodeService for API call / response to get lat & long coordinates

    require "pry"; binding.pry
    darksky_service = DarkskyService.new(coordinates)

    # query_string is icon from Darksky API

    # Dream Driving:
    darksky_service.darksky_current_summary_data.map do |summary_and_time|
      coordinates = antipode_service.get_coordinates(query_string)
      antipode_city =
      search_location =
      SomePOROtbd.new(summary_and_temp, antipode_city, search_location)
    end

    # Take query string and return ???
    antipodes_service = AntipodesService.new()

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

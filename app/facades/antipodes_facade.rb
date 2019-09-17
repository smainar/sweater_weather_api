class AntipodesFacade
  attr_reader :id, :location

  def initialize(location)
    @id = 1
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

    # Get coordinates for Antipode City
    coordinates_for_antipode_city = antipodes_service.get_formatted_lat_lng_coordinates_to_pass_to_geocode_service

    # Pass coordinates from Antipode City back to look up/return:
    #   forecast: summary & current_temp from Darksky API
    #   name of search location from Google Geocode API

    darksky_service = DarkskyService.new(coordinates_for_antipode_city)

    # look up current forecast for antipode city
    get_current_forecast_for_antipode_city = darksky_service.darksky_current_summary_data

    # What I what/need:
    antipode_city_name = GoogleGeocodeService.new(coordinates_for_antipode_city).google_geocode_raw_hash_data[:results][0][:formatted_address]
    search_location = geocode_service.google_geocode_raw_hash_data[:results][0][:address_components][0][:long_name]
    type = antipodes_service.antipode_raw_hash_data[:data][:type]
    AntipodeForecast.new(get_current_forecast_for_antipode_city[:summary], get_current_forecast_for_antipode_city[:temperature], antipode_city_name, search_location, type)

    # What I need to produce for assessment:
    # Ultimately, I want the hash to have:
    # summary & current_temp from Darksky API
    # name of search location from Google Geocode API
    # Must make make AntipodeService for API call / response to get lat & long coordinates
  end
end

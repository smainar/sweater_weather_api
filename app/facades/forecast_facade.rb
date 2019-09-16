class ForecastFacade
  attr_reader :id, :location

  def initialize(location)
    @id = 1
    @location = location
  end

  def current_weather
    CurrentWeather.new(get_darksky_forecast_data[:currently])
  end

  def hourly_weather
    get_darksky_forecast_data[:hourly][:data].map do |hour|
      HourlyWeather.new(hour)
    end.first(8)
  end

  def daily_weather
    get_darksky_forecast_data[:daily][:data].map do |day|
      DailyWeather.new(day)
    end.first(5)
  end

  private

  def geocode_service
    @geocode_service ||= GoogleGeocodeService.new(@location)
  end

  def get_location_query_coordinates
    @get_location_query_coordinates ||= geocode_service.google_geocode_query_coordinates
  end

  def get_formatted_lat_lng_coordinates
    "#{get_location_query_coordinates[:lat]},#{get_location_query_coordinates[:lng]}"
  end

  def darksky_service
    @darksky_service ||= DarkskyService.new(get_formatted_lat_lng_coordinates)
  end

  def get_darksky_forecast_data
    @get_darksky_forecast_data ||= darksky_service.darksky_raw_hash_data
  end
end

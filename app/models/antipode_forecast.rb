class AntipodeForecast
  attr_reader :antipode_city_name, :search_location, :forecast_summary, :forecast_temp

  def initialize(forecast_summary, forecast_temp, antipode_city_name, search_location, type)
    @id = 1
    @type = type
    @location_name = antipode_city_name
    @summary = forecast_summary
    @current_temperature = forecast_temp
    @search_location = search_location
  end
end

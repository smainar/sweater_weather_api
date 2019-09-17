class AntipodeForecast
  attr_reader :antipode_city_name, :search_location, :forecast_summary, :forecast_temp

  def initialize(forecast_summary, forecast_temp, antipode_city_name, search_location)
    @antipode_city_name = antipode_city_name
    @search_location = search_location
    @forecast_summary = forecast_summary
    @forecast_temp = forecast_temp
    @id = 1
  end
end

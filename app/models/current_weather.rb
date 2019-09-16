class CurrentWeather
  attr_reader :time,
              :summary,
              :icon,
              :temperature,
              :humidity,
              :uv_index,
              :visibility,
              :feels_like

  def initialize(current_forecast_data)
    @time =  current_forecast_data[:time]
    @summary = current_forecast_data[:summary]
    @icon = current_forecast_data[:icon]
    @temperature = current_forecast_data[:temperature]
    @humidity = current_forecast_data[:humidity]
    @uv_index = current_forecast_data[:uvIndex]
    @visibility = current_forecast_data[:visibility]
    @feels_like = current_forecast_data[:apparentTemperature]
  end
end

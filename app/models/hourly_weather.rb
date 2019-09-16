class HourlyWeather
  attr_reader :time,
              :summary,
              :icon,
              :temperature,
              :precipitation_probability,
              :precipitation_type

  def initialize(hourly_forecast_data)
    @time = hourly_forecast_data[:time]
    @summary = hourly_forecast_data[:summary]
    @icon = hourly_forecast_data[:icon]
    @temperature = hourly_forecast_data[:temperature]
    @precipitation_probability = hourly_forecast_data[:precipProbability]
    @precipitation_type = hourly_forecast_data[:precipType]
  end
end

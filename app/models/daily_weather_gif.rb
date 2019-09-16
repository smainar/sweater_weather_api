class DailyWeatherGif
  attr_reader :url

  def initialize(daily_forcast_summary)
    @url = daily_forcast_summary[:url]
  end
end

class ForecastFacade
  attr_reader :id, :location

  def initialize(location)
    @id = 1
    @location = location
  end

  def get_weather
    geocode_conn = Faraday.new(url: "https://maps.googleapis.com") do |f|
      f.params["address"] = location
      f.params["key"] = ENV["GOOGLE-GEOCODING-API"]
      f.adapter Faraday.default_adapter
    end

    # GoogleGecodeService
    geocode_response = geocode_conn.get("/maps/api/geocode/json?address=#{location}&key=#{ENV["GOOGLE-GEOCODING-API"]}")

    google_geocode_raw_hash_data = JSON.parse(geocode_response.body, symbolize_names: true)

    google_geocode_query_coordinates = google_geocode_raw_hash_data[:results][0][:geometry][:location]

    # Get coordinates
    latitude = google_geocode_query_coordinates[:lat]

    longitute = google_geocode_query_coordinates[:lng]

    # DarkskyService
    darksky_conn = Faraday.new(url: "https://api.darksky.net") do |f|
      f.adapter Faraday.default_adapter
    end

    darksky_response = darksky_conn.get("/forecast/#{ENV["DARK-SKY-API"]}/#{latitude},#{longitute}")

    darksky_raw_hash_data = JSON.parse(darksky_response.body, symbolize_names: true)
  end

  def current_weather
    CurrentWeather.new(get_weather[:currently])
  end

  def hourly_weather
    get_weather[:hourly][:data].map do |hour|
      HourlyWeather.new(hour)
    end.first(8)
  end

  def daily_weather
    get_weather[:daily][:data].map do |day|
      DailyWeather.new(day)
    end.first(5)
  end
end

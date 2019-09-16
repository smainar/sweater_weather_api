class ForecastFacade
  attr_reader :id, :location

  def initialize(location)
    @id = 1
    @location = location
  end

  def geocode_conn
    Faraday.new(url: "https://maps.googleapis.com") do |f|
      f.params["address"] = location
      f.params["key"] = ENV["GOOGLE-GEOCODING-API"]
      f.adapter Faraday.default_adapter
    end
  end

  def geocode_response
    geocode_conn.get("/maps/api/geocode/json?address=#{location}&key=#{ENV["GOOGLE-GEOCODING-API"]}")
  end

  def google_geocode_raw_hash_data
    JSON.parse(geocode_response.body, symbolize_names: true)
  end

  def google_geocode_query_coordinates
    google_geocode_raw_hash_data[:results][0][:geometry][:location]
  end

  def latitude
    google_geocode_query_coordinates[:lat]
  end

  def longitude
    google_geocode_query_coordinates[:lng]
  end

  def darksky_conn
    Faraday.new(url: "https://api.darksky.net") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def darksky_response
    darksky_conn.get("/forecast/#{ENV["DARK-SKY-API"]}/#{latitude},#{longitude}")
  end

  def darksky_raw_hash_data
    JSON.parse(darksky_response.body, symbolize_names: true)
  end

  def current_weather
    CurrentWeather.new(darksky_raw_hash_data[:currently])
  end

  def hourly_weather
    darksky_raw_hash_data[:hourly][:data].map do |hour|
      HourlyWeather.new(hour)
    end.first(8)
  end

  def daily_weather
    darksky_raw_hash_data[:daily][:data].map do |day|
      DailyWeather.new(day)
    end.first(5)
  end
end

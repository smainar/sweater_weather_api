class GiphyFacade
  attr_reader :location, :id

  def initialize(location)
    @location = location
    @id = id
  end

# api.giphy.com/v1/gifs/search?api_key=bZlbEtbdYXEX7rMHU5Kk0ofuoUqFXIqv&q=partly_cloudy&limit=5
  def get_giphy
    geocode_conn = Faraday.new(url: "https://maps.googleapis.com") do |f|
     f.params["address"] = location
     f.params["key"] = ENV["GOOGLE-GEOCODING-API"]
     f.adapter Faraday.default_adapter
   end

   # Move to GoogleGecodeService
   geocode_response = geocode_conn.get("/maps/api/geocode/json?address=#{location}&key=#{ENV["GOOGLE-GEOCODING-API"]}")

   google_geocode_raw_hash_data = JSON.parse(geocode_response.body, symbolize_names: true)

   google_geocode_query_coordinates = google_geocode_raw_hash_data[:results][0][:geometry][:location]

   # Get coordinates
   latitude = google_geocode_query_coordinates[:lat]

   longitute = google_geocode_query_coordinates[:lng]

   # Move to DarkskyService
   darksky_conn = Faraday.new(url: "https://api.darksky.net") do |f|
     f.adapter Faraday.default_adapter
   end

   darksky_response = darksky_conn.get("/forecast/#{ENV["DARK-SKY-API"]}/#{latitude},#{longitute}")

   darksky_raw_hash_data = JSON.parse(darksky_response.body, symbolize_names: true)

   daily_weather_summary = darksky_raw_hash_data[:daily][:data][0][:summary]

   # Giphy Connection
   giphy_conn = Faraday.new(url: "https://api.giphy.com/v1/gifs/search") do |f|
     f.params["api_key"] = ENV["GIPHY-API-KEY"]
     f.params["q"] = daily_weather_summary
     f.params["limit"] = 5
     f.adapter Faraday.default_adapter
   end

   giphy_response = giphy_conn.get("?api_key=#{ENV["GIPHY-API-KEY"]}&q=#{daily_weather_summary}&limit=5")

   giphy_raw_hash_data = JSON.parse(giphy_response.body, symbolize_names: true)

   require "pry"; binding.pry
  end

  def daily_weather_gif
    DailyWeatherGif.new()
  end
end

class GoogleGeocodeService
  def initialize(location)
    @location = location
  end

  def google_geocode_query_coordinates
    google_geocode_raw_hash_data[:results][0][:geometry][:location]
  end

  def google_geocode_raw_hash_data
    JSON.parse(geocode_response.body, symbolize_names: true)
  end
  private

  def geocode_conn
    Faraday.new(url: "https://maps.googleapis.com") do |f|
      f.params["key"] = ENV["GOOGLE-GEOCODING-API"]
      f.adapter Faraday.default_adapter
    end
  end

  def geocode_response
    geocode_conn.get("/maps/api/geocode/json?address=#{@location}")
  end

end

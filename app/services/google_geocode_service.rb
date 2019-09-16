# class GoogleGeocodeService
#   def initialize(location)
#     @location = location
#   end
#
#   def geocode_conn
#     Faraday.new(url: "https://maps.googleapis.com") do |f|
#       f.params["address"] = @location
#       f.params["key"] = ENV["GOOGLE-GEOCODING-API"]
#       f.adapter Faraday.default_adapter
#     end
#   end
#
#   def geocode_response
#     geocode_conn.get("/maps/api/geocode/json?address=#{@location}&key=#{ENV["GOOGLE-GEOCODING-API"]}")
#   end
#
#   def google_geocode_raw_hash_data
#     JSON.parse(geocode_response.body, symbolize_names: true)
#   end
#
#   def google_geocode_query_coordinates
#     google_geocode_raw_hash_data[:results][0][:geometry][:location]
#   end
#
#   def latitude
#     google_geocode_query_coordinates[:lat]
#   end
#
#   def longitude
#     google_geocode_query_coordinates[:lng]
#   end
# end

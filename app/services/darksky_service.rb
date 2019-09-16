# class DarkskyService
#     attr_reader :longitude, :latitude, :coordinates
#
#     def initialize(coordinates)
#       @coordinates = coordinates
#       # @longitude = coordinates[:lng]
#       # @latitude = coordinates[:lat]
#     end
#
#   def darksky_conn
#     Faraday.new(url: "https://api.darksky.net") do |f|
#       f.adapter Faraday.default_adapter
#     end
#   end
#
#   def darksky_response
#     darksky_conn.get("/forecast/#{ENV["DARK-SKY-API"]}/#{@coordinates[:lat]},#{@coordinates[:lng]}")
#   end
#
#   def darksky_raw_hash_data
#     JSON.parse(darksky_response.body, symbolize_names: true)
#   end
# end

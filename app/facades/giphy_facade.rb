class GiphyFacade
  attr_reader :location, :id

  def initialize(location)
    @location = location
    @id = id
  end

# api.giphy.com/v1/gifs/search?api_key=bZlbEtbdYXEX7rMHU5Kk0ofuoUqFXIqv&q=partly_cloudy&limit=5
   def get_giphy
     giphy_conn = Faraday.new(url: "https://api.giphy.com/v1/gifs/search") do |f|
       f.params["api_key"] = ENV["GIPHY-API-KEY"]
       f.params["q"] = location
       f.params["limit"] = 5
       f.adapter Faraday.default_adapter
     end
  end
end

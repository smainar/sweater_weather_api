class UnsplashService
  def initialize(location)
    @location = location
  end

  def unsplash_conn
     Faraday.new(url: "https://api.unsplash.com") do |f|
      f.params["client_id"] = ENV["UNSPLASH-ACCESS-KEY"]
      f.adapter Faraday.default_adapter
    end
  end

  def unsplash_response
     unsplash_conn.get("/search/photos?query=#{@location}")
  end

  def unsplash_raw_hash_data
     JSON.parse(unsplash_response.body, symbolize_names: true)
  end
end

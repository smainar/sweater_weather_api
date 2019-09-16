class DarkskyService
  def initialize(coordinates)
    @coordinates = coordinates
  end

  def darksky_raw_hash_data
    JSON.parse(darksky_response.body, symbolize_names: true)
  end

  private

  def darksky_conn
    Faraday.new(url: "https://api.darksky.net") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def darksky_response
    darksky_conn.get("/forecast/#{ENV["DARK-SKY-API"]}/#{@coordinates}")
  end
end

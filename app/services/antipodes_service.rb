class AntipodesService
  def initialize(coordinates)
    @coordinates = coordinates
  end

  # http://amypode.herokuapp.com/api/v1/antipodes?lat=22.3193039&long=114.1693611

  def antipode_conn
    Faraday.new(url: "http://amypode.herokuapp.com") do |f|
      f.headers["api_key"] = ENV["ANTIPODE-API-KEY"]
      f.adapter Faraday.default_adapter
    end
  end

  def antipode_response
    antipode_conn.get("/api/v1/antipodes?lat=22.3193039&long=114.1693611")
  end

  def antipode_raw_hash_data
    JSON.parse(antipode_response.body, symbolize_names: true)
  end
end

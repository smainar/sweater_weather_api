require "rails_helper"

RSpec.describe "Giphy API Endpoint" do
  it "returns an animated GIFs using weather data from the Dark Sky API" do
    city_and_state = "denver,co"

    get "/api/v1/gifs?location=#{city_and_state}"

    expect(response).to be_successful

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response[:data]).to be_present
    expect(parsed_response[:data].class).to eq(Hash)
    expect(parsed_response[:data].keys).to eq([:id, :type, :attributes])
  end
end

require "rails_helper"

RSpec.describe "Unsplash API Endpoint" do
  it "returns a background image url for a city" do
    city_and_state = "denver,co"

    get "/api/v1/backgrounds?location=#{city_and_state}"

    expect(response).to be_successful

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response[:data]).to be_present
    expect(parsed_response[:data].class).to eq(Hash)
    expect(parsed_response[:data].keys).to eq([:id, :type, :attributes])
  end
end

require "rails_helper"

RSpec.describe "Forecast API Endpoint" do
  it "returns the weather forecast for a specific city" do
    city_and_state = "denver,co"

    get "/api/v1/forecast?location=#{city_and_state}"

    expect(response).to be_successful

    parsed_forecast = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_forecast[:data]).to be_present
    expect(parsed_forecast[:data].class).to eq(Hash)
    expect(parsed_forecast[:data][:attributes].keys).to eq([:current_weather, :hourly_weather, :daily_weather])
    expect(parsed_forecast[:data][:attributes][:current_weather].count).to eq(8)
    expect(parsed_forecast[:data][:attributes][:hourly_weather].count).to eq(8)
    expect(parsed_forecast[:data][:attributes][:daily_weather].count).to eq(5)
  end
end

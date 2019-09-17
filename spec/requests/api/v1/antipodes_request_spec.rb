require "rails_helper"

RSpec.describe "Antipode API Endpoint" do
  it "returns an animated GIFs using weather data from the Dark Sky API" do
    city = "hongkong"

    get "/api/v1/antipode?loc=#{city}"

    expect(response).to be_successful

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response[:data]).to be_present
    expect(parsed_response[:data].class).to eq(Array)
    expect(parsed_response[:data][0].keys).to eq([:id, :type, :attributes])
  end
end

# RESPONSE:
# {
#     "data": [
#         {
#             "id": "1",
#             "type": "antipode",
#             "attributes": {
#                 "location_name": "Antipode City Name",
#                 "forecast": {
#                     "summary": "Mostly Cloudy,
#                     "current_temperature": "72",
#                                 },
#             "search_location": "Hong Kong"
#             }
#         }
#     ]
# }

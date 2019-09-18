require "rails_helper"

RSpec.describe "User Registration Endpoint" do
  it "creates an account for a user when all required fields are submitted" do
    request_body = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    headers = {
      "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json"
    }

    post "/api/v1/users", params: request_body.to_json, headers: headers

    expect(response).to be_successful

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(User.count).to eq(1)
    expect(parsed_response).to have_key(:api_key)
  end

  it "fails to create an account for a user when required fields are missing and returns an error message" do
    request_body = {
      "email": "whatever@example.com",
      # "password": "password",
      "password_confirmation": "password"
    }

    headers = {
      "CONTENT_TYPE" => "application/json",
      "ACCEPT" => "application/json"
    }

    post "/api/v1/users", params: request_body.to_json, headers: headers

    expect(response).to have_http_status(400)

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(User.count).to eq(0)
    expect(parsed_response[:error]).to eq("Password can't be blank")
  end
end

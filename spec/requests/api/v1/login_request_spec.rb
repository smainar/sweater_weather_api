require "rails_helper"

RSpec.describe "Login Endpoint" do
  before :each do
    @request_body = {
      email: "whatever@example.com",
      password: "password"
    }

    @user = User.create!(@request_body)
  end

  it "creates a session for a user when all required fields are submitted" do
    post "/api/v1/sessions", params: @request_body

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response[:api_key]).to eq(@user.api_key)
  end

  it "fails to create a session for a user when required fields are missing and returns an error message" do
    request_body = {
      email: "whatever@example.com"
    }

    post "/api/v1/sessions", params: request_body

    expect(response.status).to eq(401)

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response[:error]).to eq("Incorrect email and/or password.")
  end
end

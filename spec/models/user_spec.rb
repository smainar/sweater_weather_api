require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe "instance methods" do
    it "#generate_api_key" do
      request_body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }

      user = User.create!(request_body)

      expect(user.api_key).to_not be_nil
    end
  end
end

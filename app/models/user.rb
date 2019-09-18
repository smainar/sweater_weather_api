class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  after_create :generate_api_key

  def generate_api_key
    self.update(api_key: SecureRandom.hex)
  end
end

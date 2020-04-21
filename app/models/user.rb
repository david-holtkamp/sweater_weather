class User < ApplicationRecord
  validates_presence_of :password_digest
  validates :email, uniqueness: true, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates :api_key, uniqueness: true
  validates :password_confirmation, length: { minimum: 4 }
  has_secure_password
  has_secure_token :api_key
end

class User < ApplicationRecord
  validates :email, presence: true
  validates :password_digest, presence: true
  # automatically handles password hashing and verification
  # stores password in password_digest column
  has_secure_password
end

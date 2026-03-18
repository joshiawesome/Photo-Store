class User < ApplicationRecord
  validates :email, presence: { message: Messages::ERROR[:empty_email] }, uniqueness: { message: Messages::ERROR[:existing_account] }, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/, message: Messages::ERROR[:invalid_email] }
  validates :password, presence: { message: Messages::ERROR[:empty_password] }
  # automatically handles password hashing and verification
  # stores password in password_digest column
  has_secure_password
end

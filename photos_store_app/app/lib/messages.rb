module Messages
  SUCCESS = {
    user_created: "Account created successfully!",
    user_logged_in: "Logged in successfully!",
    user_logged_out: "Logged out successfully!"
  }.freeze

  ERROR = {
    empty_email: "Please enter your email",
    invalid_email: "Please enter a valid email id",
    empty_password: "Please set a password",
    existing_account: "Account already exists",
    invalid_credentials: "Please login with valid credentials"
  }.freeze
end
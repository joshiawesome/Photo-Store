module Messages
  SUCCESS = {
    user_created: "User created successfully"
  }.freeze

  ERROR = {
    empty_email: "Please enter your email",
    empty_password: "Please set a password",
    existing_account: "Account already exists"
  }.freeze
end
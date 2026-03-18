require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome_email" do
    user = User.new(email: "turtle@example.com", password: "123")

    email = UserMailer.welcome_email(user)


    assert_equal ["turtle@example.com"], email.to
    assert_equal ["dfelips@gmail.com"], email.from
    assert_equal "Welcome!", email.subject

    assert_match "Thanks for signing up", email.body.encoded
  end
end
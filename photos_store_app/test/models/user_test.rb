require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should create a user with valid attributes" do
    user = User.new(
      email: "test@example.com",
      password_digest: "123"
    )

    assert user.save
  end


  test "should not create a user with existing email" do
    assert_raises(ActiveRecord::RecordNotUnique) do
      user = User.new(
        email: "test1@example.com",
        password_digest: "123"
      )
      user.save
    end
  end

  test "should not create a user without email" do
    user = User.new(
      password_digest: "123"
    )
   
    assert_not user.save
  end

  test "should not create a user without password" do
    user = User.new(
      email: "test2@example.com"
    )
   
    assert_not user.save
  end
end

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should create a user with valid attributes" do
    user = User.new(
      email: "test@example.com",
      password: "123"
    )

    assert user.save
  end


  test "should not create a user with existing account" do
    # assert_raises(ActiveRecord::RecordNotUnique) do
    # end
    user = User.new(
      email: "test1@example.com",
      password: "123"
    )

    user.save

    err = user.errors[:email].first
    assert_equal Messages::ERROR[:existing_account], err
  end

  test "should not create a user without email" do
    user = User.new(
      password: "123"
    )
   
    assert_not user.save
    err = user.errors[:email].first
    assert_equal Messages::ERROR[:empty_email], err
  end

  test "should not create a user without password" do
    user = User.new(
      email: "test2@example.com"
    )
   
    assert_not user.save
    err = user.errors[:password].first
    assert_equal Messages::ERROR[:empty_password], err
  end
end

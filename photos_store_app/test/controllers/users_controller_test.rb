require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user with valid params" do
    valid_params = { user: { email: "turtle@example.com", password: "password123" } }
    
    assert_difference "User.count", 1 do
      post users_url, params: valid_params, as: :json
    end

    assert_response :created

    msg = response.parsed_body["message"]
    assert_equal Messages::SUCCESS[:user_created], msg

    assert User.find_by(email: "turtle@example.com")
  end

  test "should not create user with existing account" do
    User.create(email: "otter@example.com", password: "123")
    
    invalid_params = { user: { email: "otter@example.com", password: "123" } }

    assert_no_difference "User.count" do
      post users_url, params: invalid_params, as: :json
    end
  
    assert_response :unprocessable_entity

    json_response = response.parsed_body

    assert json_response.key?("email")

    err = json_response["email"].first
    assert_equal Messages::ERROR[:existing_account], err
  end


  test "should not create user with empty email" do
    invalid_params = { user: { email: "", password: "password123" } }

    assert_no_difference "User.count" do
      post users_url, params: invalid_params, as: :json
    end
  
    assert_response :unprocessable_entity

    json_response = response.parsed_body

    assert json_response.key?("email")

    err = json_response["email"].first
    assert_equal Messages::ERROR[:empty_email], err
  end

  test "should not create user with invalid email" do
    invalid_params = { user: { email: "turtle", password: "password123" } }

    assert_no_difference "User.count" do
      post users_url, params: invalid_params, as: :json
    end
  
    assert_response :unprocessable_entity

    json_response = response.parsed_body

    assert json_response.key?("email")

    err = json_response["email"].first
    assert_equal Messages::ERROR[:invalid_email], err
  end

  test "should not create user with empty password" do
    invalid_params = { user: { email: "turtle@example.com", password: "" } }

    assert_no_difference "User.count" do
      post users_url, params: invalid_params, as: :json
    end
  
    assert_response :unprocessable_entity

    json_response = response.parsed_body

    assert json_response.key?("password")

    err = json_response["password"].first
    assert_equal Messages::ERROR[:empty_password], err
  end
end

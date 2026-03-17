require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user with valid params" do
    valid_params = { user: { email: "turtle@example.com", password: "password123" } }
 
    assert_difference "User.count", 1 do
      post users_url, params: valid_params, as: :json
    end

    assert_response :created

    assert_equal "turtle@example.com", response.parsed_body["email"]

    assert User.find_by(email: "turtle@example.com")
  end


  test "should not create user with empty email" do
    invalid_params = { user: { email: "", password: "password123" } }

    assert_no_difference "User.count" do
      post users_url, params: invalid_params, as: :json
    end
  
    assert_response :unprocessable_entity

    json_response = response.parsed_body

    assert json_response.key?("email")

    assert_includes json_response["email"], "can't be blank"
  end

  test "should not create user with empty password" do
    invalid_params = { user: { email: "turtle@example.com", password: "" } }

    assert_no_difference "User.count" do
      post users_url, params: invalid_params, as: :json
    end
  
    assert_response :unprocessable_entity

    json_response = response.parsed_body

    assert json_response.key?("password")

    assert_includes json_response["password"], "can't be blank"
  end
end

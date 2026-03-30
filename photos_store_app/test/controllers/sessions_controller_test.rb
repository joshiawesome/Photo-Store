require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should create session with valid params" do
    User.create(email: "turtle@example.com", password: "password123")
    
    valid_params = { email: "turtle@example.com", password: "password123" }
    
    post login_url, params: valid_params, as: :json
    
    assert_response :ok
    
    msg = response.parsed_body["message"]
    assert_equal Messages::SUCCESS[:user_logged_in], msg
    
    email = response.parsed_body["user"]["email"]
    assert_equal "turtle@example.com", email
  end

  test "should not create session with invalid params" do
    invalid_params = { email: "turtle@example.com", password: "wrongpassword" }
    
    post login_url, params: invalid_params, as: :json
    
    assert_response :unauthorized
    
    msg = response.parsed_body["error"]
    assert_equal Messages::ERROR[:invalid_credentials], msg
  end
  
  test "should destroy session with valid params" do
    User.create(email: "turtle@example.com", password: "password123")
    
    valid_params = { email: "turtle@example.com", password: "password123" }
    
    post login_url, params: valid_params, as: :json
    
    assert_response :ok
    
    msg = response.parsed_body["message"]
    assert_equal Messages::SUCCESS[:user_logged_in], msg
    
    email = response.parsed_body["user"]["email"]
    assert_equal "turtle@example.com", email
    
    delete logout_url, as: :json
    
    assert_response :ok
    
    msg = response.parsed_body["message"]
    assert_equal Messages::SUCCESS[:user_logged_out], msg
  end

  test "should return current user when logged in" do
    user = User.create(email: "turtle@example.com", password: "password123")

    post login_url, params: { email: "turtle@example.com", password: "password123" }, as: :json
    assert_response :ok

    get session_url, as: :json

    assert_response :ok

    email = response.parsed_body["user"]["email"]
    assert_equal user.email, email
  end

  test "should return unauthorized when not logged in" do
    get session_url, as: :json

    assert_response :unauthorized

    error = response.parsed_body["error"]
    assert_equal Messages::ERROR[:not_logged_in], error
  end

end

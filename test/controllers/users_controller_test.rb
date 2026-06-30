require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user" do
    assert_difference("User.count", 1) do
      post users_url, params: { user: { email_address: "email_address", password: "password", password_confirmation: "password" } }
    end

    assert_redirected_to new_session_url
  end

  test "should not create user if validation fails" do
    assert_no_difference("User.count") do
      post users_url, params: { user: {} }
    end

    assert_response :bad_request
  end

  test "should not create user if email is taken" do
    @taken_email_address = users(:user_one).email_address

    assert_no_difference("User.count") do
      post users_url, params: { user: { email_address: @taken_email_address, password: "password", password_confirmation: "password" } }
    end

    assert_response :unprocessable_entity
  end
end

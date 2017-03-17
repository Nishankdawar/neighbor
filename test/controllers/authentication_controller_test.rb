require 'test_helper'

class AuthenticationControllerTest < ActionController::TestCase
  test "should get signup_get" do
    get :signup_get
    assert_response :success
  end

end

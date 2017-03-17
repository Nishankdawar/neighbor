require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create_clack" do
    get :create_clack
    assert_response :success
  end

  test "should get like" do
    get :like
    assert_response :success
  end

  test "should get follow" do
    get :follow
    assert_response :success
  end

  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get followers" do
    get :followers
    assert_response :success
  end

  test "should get followees" do
    get :followees
    assert_response :success
  end

end

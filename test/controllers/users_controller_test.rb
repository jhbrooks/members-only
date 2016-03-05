require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
  end

  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    post :create, user: { name: "Ex", password: "password",
                                      password_confirmation: "password" }
    assert_response :redirect
  end
end

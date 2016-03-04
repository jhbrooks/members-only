require 'test_helper'

class UsersControllerTest < ActionController::TestCase
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

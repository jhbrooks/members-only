require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new when logged in" do
    log_in_as(@user)
    get :new
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  test "should post create when logged in" do
    log_in_as(@user)
    post :create, post: { body: "Lorem ipsum." }
    assert_redirected_to posts_url
  end

  test "should redirect create when not logged in" do
    post :create, post: { body: "Lorem ipsum." }
    assert_redirected_to login_url
  end
end

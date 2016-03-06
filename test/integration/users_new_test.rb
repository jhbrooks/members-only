require 'test_helper'

class UsersNewTest < ActionDispatch::IntegrationTest
  test "invalid new user" do
    get root_path
    assert_template "posts/index"
    assert_select "a[href=?]", signup_path
    get signup_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      post signup_path, user: { name: "   ",
                                password: "   ", password_confirmation: "   " }
    end
    assert_template "users/new"
    assert_template "shared/_error_messages"
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end

  test "valid new user" do
    get root_path
    assert_template "posts/index"
    assert_select "a[href=?]", signup_path
    get signup_path
    assert_template "users/new"
    assert_difference "User.count", 1 do
      post signup_path, user: { name: "Ex",
                                password: "password",
                                password_confirmation: "password" }
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_not flash.empty?
    assert is_test_user_logged_in?
  end
end

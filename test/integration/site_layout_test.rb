require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "layout when logged out" do
    get root_path
    assert_template "posts/index"
    assert_select "title", text: full_title("Posts")
    assert_select "a[href=?]", posts_path, count: 1
    assert_select "a[href=?]", new_post_path, count: 0
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", signup_path, count: 1
    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", logout_path, count: 0

    get login_path
    assert_template "sessions/new"
    assert_select "title", text: full_title("Log in")
    assert_select "a[href=?]", posts_path, count: 1
    assert_select "a[href=?]", new_post_path, count: 0
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", logout_path, count: 0

    get signup_path
    assert_template "users/new"
    assert_select "title", text: full_title("Sign up")
    assert_select "a[href=?]", posts_path, count: 1
    assert_select "a[href=?]", new_post_path, count: 0
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", signup_path, count: 1
    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "layout when logged in" do
    log_in_as(@user)

    get root_path
    assert_template "posts/index"
    assert_select "title", text: full_title("Posts")
    assert_select "a[href=?]", posts_path, count: 1
    assert_select "a[href=?]", new_post_path, count: 1
    assert_select "a[href=?]", users_path, count: 1
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 1

    get new_post_path
    assert_template "posts/new"
    assert_select "title", text: full_title("New post")
    assert_select "a[href=?]", posts_path, count: 1
    assert_select "a[href=?]", new_post_path, count: 1
    assert_select "a[href=?]", users_path, count: 1
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path

    get users_path
    assert_template "users/index"
    assert_select "title", text: full_title("Users")
    assert_select "a[href=?]", posts_path, count: 1
    assert_select "a[href=?]", new_post_path, count: 1
    assert_select "a[href=?]", users_path, count: 1
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 1
  end
end

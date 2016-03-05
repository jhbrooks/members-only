require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "layout when logged out" do
    get root_path
    assert_template "posts/index"
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", new_post_path, count: 0
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", posts_path, count: 0
    assert_select "a[href=?]", new_user_path

    get login_path
    assert_template "sessions/new"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", new_post_path, count: 0
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", new_user_path

    get new_user_path
    assert_template "users/new"
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", new_post_path, count: 0
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", new_user_path, count: 0
  end

  test "layout when logged in" do
    log_in_as(@user)

    get root_path
    assert_template "posts/index"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", new_post_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", posts_path, count: 0
    assert_select "a[href=?]", new_user_path, count: 0

    get new_post_path
    assert_template "posts/new"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", new_post_path, count: 0
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", new_user_path, count: 0

    get users_path
    assert_template "users/index"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", new_post_path
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", new_user_path, count: 0
  end
end

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "invalid login" do
    get login_path
    assert_template "sessions/new"
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", new_user_path
    post login_path, session: { name: "Rando", password: "foo" }
    assert_not flash.empty?
    get posts_path
    assert flash.empty?
  end

  test "valid login and valid logout" do
    get login_path
    assert_template "sessions/new"
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", new_user_path
    post login_path, session: { name: "ex_one", password: "password" }
    assert is_test_user_logged_in?
    assert_redirected_to posts_path

    delete logout_path
    assert_not is_test_user_logged_in?
    assert_redirected_to posts_path
  end
end

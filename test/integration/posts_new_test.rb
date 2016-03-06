require 'test_helper'

class PostsNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "invalid new post" do
    log_in_as(@user)
    get root_path
    assert_template "posts/index"
    assert_select "a[href=?]", new_post_path
    get new_post_path
    assert_template "posts/new"
    assert_select "label", text: @user.name
    assert_no_difference "Post.count" do
      post posts_path, post: { body: "   " }
    end
    assert_template "posts/new"
    assert_template "shared/_error_messages"
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end

  test "valid new post with friendly forwarding" do
    get root_path
    assert_template "posts/index"
    get new_post_path
    log_in_as(@user)
    assert_redirected_to new_post_path
    follow_redirect!
    assert_template "posts/new"
    assert_select "label", text: @user.name
    assert_difference "Post.count", 1 do
      post posts_path, post: { body: "Lorem ipsum." }
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_not flash.empty?
  end
end

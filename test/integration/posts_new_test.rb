require 'test_helper'

class PostsNewTest < ActionDispatch::IntegrationTest
  test "invalid new post" do
    get root_path
    assert_template "posts/index"
    assert_select "a[href=?]", new_post_path
    assert_select "a[href=?]", new_user_path
    get new_post_path
    assert_template "posts/new"
    assert_select "a[href=?]", posts_path
    assert_no_difference "Post.count" do
      post posts_path, post: { body: "   " }
    end
    assert_template "posts/new"
    assert_template "shared/_error_messages"
  end

  test "valid new post" do
    get root_path
    assert_template "posts/index"
    assert_select "a[href=?]", new_post_path
    assert_select "a[href=?]", new_user_path
    get new_post_path
    assert_template "posts/new"
    assert_select "a[href=?]", posts_path
    assert_difference "Post.count", 1 do
      post posts_path, post: { body: "Lorem ipsum." }
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_not flash.empty?
  end
end

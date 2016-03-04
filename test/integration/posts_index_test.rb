require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "index of posts when logged out" do
    get posts_path
    assert_template "posts/index"
    Post.all.each do |_post|
      assert_select "p", text: "Lorem ipsum."
    end
  end

  test "index of posts when logged in" do
    log_in_as(@user)
    get posts_path
    assert_template "posts/index"
    Post.all.each do |post|
      # assert_select "p", text: "#{post.user.name}"
      assert_select "p", text: "Lorem ipsum."
    end
  end
end

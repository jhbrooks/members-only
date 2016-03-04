require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest
  test "index of posts" do
    get posts_path
    assert_template "posts/index"
    Post.all.each do |_post|
      assert_select "li", text: "Lorem ipsum."
    end
  end
end

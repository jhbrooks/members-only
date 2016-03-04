require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = Post.new(body: "Lorem ipsum.")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "body should be present" do
    @post.body = "   "
    assert_not @post.valid?
  end
end

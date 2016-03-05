require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @post = posts(:one)

    @post.created_at += 3600
    @post.save
  end

  test "index of posts when logged out with pagination and ordering" do
    get posts_path
    assert_template "posts/index"

    # Tests that the most recently created post shows up first.
    assert_select "p", text: "Posted at #{@post.created_at}"
    assert_select "p", text: @post.body

    Post.order(created_at: :desc).offset(1).paginate(page: 1).each do |post|
      assert_select "p", text: post.user.name, count: 0
      assert_select "p", text: "Posted at #{post.created_at}"
      assert_select "p", text: post.body
    end

    User.all.each do |user|
      assert_select "li", text: user.name, count: 0
    end

    get posts_path, page: '2'
    assert_template "posts/index"
    Post.order(created_at: :desc).offset(1).paginate(page: 2).each do |post|
      assert_select "p", text: post.user.name, count: 0
      assert_select "p", text: "Posted at #{post.created_at}"
      assert_select "p", text: post.body
    end

    User.all.each do |user|
      assert_select "li", text: user.name, count: 0
    end
  end

  test "index of posts when logged in with pagination and ordering" do
    log_in_as(@user)

    get posts_path
    assert_template "posts/index"

    # Tests that the most recently created post shows up first.
    assert_select "p", text: "Posted at #{@post.created_at}"
    assert_select "p", text: @post.body
    
    Post.order(created_at: :desc).offset(1).paginate(page: 1).each do |post|
      assert_select "p", text: post.user.name
      assert_select "p", text: "Posted at #{post.created_at}"
      assert_select "p", text: post.body
    end

    User.all.each do |user|
      assert_select "li", text: user.name
    end

    get posts_path, page: '2'
    assert_template "posts/index"
    Post.order(created_at: :desc).offset(1).paginate(page: 2).each do |post|
      assert_select "p", text: post.user.name
      assert_select "p", text: "Posted at #{post.created_at}"
      assert_select "p", text: post.body
    end

    User.all.each do |user|
      assert_select "li", text: user.name
    end
  end
end

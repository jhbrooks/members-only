require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)

    more_recent_date = @user.created_at + 3600
    @user.update_attributes(password: "password",
                            created_at: more_recent_date)
    @user.save!
  end

  test "index of users with pagination and ordering" do
    log_in_as(@user)

    get users_path
    assert_template "users/index"

    # Tests that the most recently created user shows up first.
    assert_select "p", text: @user.name
    assert_select "p", text: "Member since #{@user.created_at}"

    User.order(created_at: :desc).offset(1).paginate(page: 1).each do |user|
      assert_select "p", text: user.name
      assert_select "p", text: "Member since #{user.created_at}"
    end

    get users_path, page: '2'
    assert_template "users/index"
    User.order(created_at: :desc).offset(1).paginate(page: 2).each do |user|
      assert_select "p", text: user.name
      assert_select "p", text: "Member since #{user.created_at}"
    end
  end
end

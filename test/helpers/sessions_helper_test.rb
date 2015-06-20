#include test_helper.rb
require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  #create a dummy user to use in testing. This is pulling from fixtures
  def setup
    @user = users(:michael)
    #remember (method from model)
    remember(@user)
  end

  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
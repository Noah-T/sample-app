require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "test login" do 
  	#go to login
  	get '/login'
  	#check to make sure that the new session (login) form is displayed
  	assert_template 'sessions/new'
  	#send a post with empty email and password (this should be invalid)
  	post login_path session: { email: "", password: "" }
  	#this should kick user back to the new session (login) form
  	assert_template 'sessions/new'
  	#the flash message should show a warning and therefore not be empty
  	assert_not flash.empty?
  	#go to home page
  	get root_path
  	#now the flash message should be empty
  	assert flash.empty?

  end

  test "login with valid information" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    #assigns gets @user instance variable from controller in integration tests
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end

require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
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
end

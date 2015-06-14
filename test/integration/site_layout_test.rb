require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    #go to home page
    get root_path
    #the static_pages/home template should be displayed
    assert_template 'static_pages/home'
    #the path specified in href should match root_path, count 2 checks that there should be two links like this on the page
    #one link for the logo, one in the nav menu
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    get signup_path
    assert_template 'users/new'
  end
end

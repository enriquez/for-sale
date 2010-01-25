require 'test_helper'

class AuthenticationTest < ActionController::IntegrationTest
  context "an administrator" do
    setup do
      @administrator = Factory(:administrator)
    end
    
    should "login" do
      login_with "admin", "password"
      
      assert_path "/admin"
    end
    
    should "not login" do
      login_with "badlogin", "badpassword"
      
      assert_path "/user_sessions"
      
      visit "/admin"
      assert_path "/login"
    end
    
    should "logout" do
      login_with "admin", "password"
      click_link "Logout"
      
      assert_path "/login"
      
      visit "/admin"
      assert_path "/login"
    end
  end
end

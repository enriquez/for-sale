require 'test_helper'

class ConfigUsersTest < ActionController::IntegrationTest
  context "logged in config" do
    setup do
      basic_auth(APP_CONFIG["config_login"], APP_CONFIG["config_password"])
    end
    
    should "create a user" do
      visit "/config/users/new"
      
      assert_contain "Create a User"
      
      fill_in "Login", :with => "first_user"
      fill_in "Password", :with => "password"
      fill_in "Password Confirmation", :with => "password"
      click_button "Create"
      
      assert_equal 1, User.count
      assert_contain "User was created"
    end
    
    should "create an admin" do
      visit "/config/users/new"
      
      select "Admin", :from => "Role"
      fill_in "Login", :with => "admin"
      fill_in "Password", :with => "password"
      fill_in "Password Confirmation", :with => "password"
      click_button "Create"
      
      assert_equal "Admin", User.first.role
    end
    
    should "update a user" do
      user = Factory(:user)
      visit "/config/users/#{user.id}/edit"
      
      assert_contain "Edit a User"
      
      fill_in "Login", :with => "mike"
      fill_in "Password", :with => "pizza"
      fill_in "Password Confirmation", :with => "pizza"
      click_button "Update"
      
      assert_equal 1, User.count
      assert_contain "User was updated"
      assert_equal "mike", user.reload.login
    end
    
    should "list all users" do
      Factory(:user, :login => "number_one")
      Factory(:user, :login => "numero_dos")
      
      visit "/config/users"
      
      assert_contain "number_one"
      assert_contain "numero_dos"
    end
    
    should "delete a user" do
      Factory(:user, :login => "kewl_guy")
      
      visit "/config/users"
      click_link "Delete"
      
      assert_equal 0, User.count
      assert_contain "User was deleted"
    end
  end
end

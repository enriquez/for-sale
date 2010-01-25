require 'test_helper'

class VisitorContactTest < ActionController::IntegrationTest
  context "visitor fills out a valid contact form" do
    setup do
      ActionMailer::Base.deliveries.clear
      visit "/"
      fill_in "Name", :with => "Mike Enriquez"
      fill_in "Email", :with => "mike@enriquez.me"
      fill_in "Phone", :with => "216.225.7223"
      fill_in "Message", :with => "I want to buy everything for a million dollars"
      click_button "Send"
    end

    should "send an email" do
      assert_equal 1, ActionMailer::Base.deliveries.size
    end

    should "flash message" do
      assert_contain "Thank you. We will get back to you as soon as possible"
    end
  end
end

require 'test_helper'

class AdminProductsTest < ActionController::IntegrationTest
  context "a logged in admin" do
    setup do
      Factory(:administrator)
      login_with("admin", "password")
    end

    should "create a product" do
      visit "/admin/products/new"
      fill_in "Title", :with => "Sofa and Love Seat"
      fill_in "Price", :with => "350.00"
      fill_in "Description", :with => "Excellent condition, over a year old"
      click_button "Create"

      assert_equal 1, Product.count
      assert_equal "Sofa and Love Seat", Product.first.title
      assert_equal 350.0, Product.first.price
      assert_equal "Excellent condition, over a year old", Product.first.description
    end

    should "show a product" do
      product = Factory(:product, :title => "Show me the money")
      visit "/admin/products/#{product.id}"

      assert_contain "Show me the money"
    end

    should "list products" do
      Factory(:product, :title => "Chair")
      Factory(:product, :title => "Desk")
      visit "/admin/products"

      assert_contain "Chair"
      assert_contain "Desk"
    end

    should "edit a product" do
      product = Factory(:product, :title => "Laptop")
      visit "/admin/products/#{product.id}/edit"
      fill_in "Title", :with => "Tablet"
      click_button "Update"

      product.reload
      assert_equal "Tablet", product.title
    end

    should "delete a product" do
      Factory(:product)
      visit "/admin/products"
      click_link "Delete"

      assert_equal 0, Product.count
    end
  end
end

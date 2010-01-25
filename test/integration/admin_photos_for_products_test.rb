require 'test_helper'

class AdminPhotosForProductsTest < ActionController::IntegrationTest
  context "logged in admin" do
    setup do
      Photo.any_instance.stubs(:save_attached_files).returns(true)
      Photo.any_instance.stubs(:destroy_attached_files).returns(true)
      
      @photo_1 = Factory(:photo, :file => File.open("#{RAILS_ROOT}/test/fixtures/images/pic.jpg"),
        :description => "Picture 1")
      @photo_2 = Factory(:photo, :file => File.open("#{RAILS_ROOT}/test/fixtures/images/pic.jpg"),
        :description => "Photograph 2")
      @product = Factory(:product, :photo_ids => [@photo_1.id, @photo_2.id])
      
      Factory(:administrator)
      login_with "admin", "password"
    end
    
    should "list photos for a product" do
      visit "/admin/products/#{@product.id}"
      
      assert_contain "Picture 1"
      assert_contain "Photograph 2"
    end
    
    should "delete a photo" do
      visit "/admin/products/#{@product.id}"
      click_link "Delete"
      
      assert_equal 1, Photo.count
    end
    
    should "update a photo" do
      visit "/admin/products/#{@product.id}"
      click_link "Edit"
      
      assert_path "/admin/products/#{@product.to_param}/photos/#{@photo_1.id}/edit"
      fill_in "Description", :with => "this is a description"
      click_button "Update"
      
      assert_equal "this is a description", @photo_1.reload.description
    end
    
    should "upload more photos" do
      visit "/admin/products/#{@product.id}"
      click_link "Upload Photos"
      
      assert_path "/admin/products/#{@product.to_param}/photos/new"
    end
  end
end

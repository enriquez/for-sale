module Admin::PhotosHelper
  
  def photo_items(parent)
    [
      { :name => "List Photos", :path => polymorphic_path([:admin, parent])},
      { :name => "Upload Photos", :path => polymorphic_path([:admin, parent, :photo], :action => :new)}
    ]
  end
  
  def photo_navigation(parent, active_position = nil)
    items = photo_items(parent)
    items.each do |navigation_item|
      navigation_item[:class] = ""
    end
    items.first[:class] = "first "
    items[active_position][:class] << "active" if active_position
    items
  end
  
  def new_photo_path_with_session_information
    session_key = ActionController::Base.session_options[:key]
    admin_photos_path(session_key => cookies[session_key], request_forgery_protection_token => form_authenticity_token)
  end

end

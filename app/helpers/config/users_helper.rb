module Config::UsersHelper
  def navigation_items
    [
      { :name => "List Users", :path => config_users_path },
      { :name => "Create a User", :path => new_config_user_path }
    ]
  end
end

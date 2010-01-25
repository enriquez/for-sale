class Config::BaseController < ApplicationController
  before_filter :authenticate_config
  layout "config"
  
  private
  def authenticate_config
    authenticate_or_request_with_http_basic do |username, password|
      username == APP_CONFIG["config_login"] && password == APP_CONFIG["config_password"]
    end
  end
end

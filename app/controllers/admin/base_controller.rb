class Admin::BaseController < ApplicationController
  before_filter :authenticate_administrator
  layout "admin"

  private
  def authenticate_administrator
    if current_user.nil? || current_user.role != "Admin"
      redirect_to login_path
    end
  end
end

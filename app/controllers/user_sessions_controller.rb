class UserSessionsController < ApplicationController
  layout nil
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      if current_user.role == "Admin"
        redirect_to admin_url
      else
        redirect_to :action => 'new'
      end
    else
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to login_url
  end
end

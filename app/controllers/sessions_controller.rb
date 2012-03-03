class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
  end

  def create
    user = User.find_by_email(params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :controller => 'welcome'
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :controller => 'welcome', :notice => "Logged out"
  end

end

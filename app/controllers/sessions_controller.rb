class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      user.last_login = today
      user.save()
      redirect_to :controller => 'welcome'
    else
      flash[:error] = 'Invalid user/password combination'
     redirect_to login_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You are logged out now.'
    redirect_to :controller => 'welcome'
  end

end

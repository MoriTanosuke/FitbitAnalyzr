require 'json'

class WelcomeController < ApplicationController
  skip_before_filter :authorize

  def index
    @user = current_user
    @lastSync = 'unknown'
    @battery = 'unknown'
    if not @user.nil? and not @user.fitbit.nil?
      begin
        devices = JSON.parse(@user.fitbit.client.get('/1/user/-/devices.json', { 'Accept' => 'application/json' }).body)
        @lastSync = devices[0]['lastSyncTime']
        @battery = devices[0]['battery']
      rescue SocketError
        logger.error "Can not talk to fitbit"
      end
    end
  end

  def contact
    # TODO put email into request is user is logged in
    if logged_in?
      @user = current_user.email
    end
  end

  def feedback
    respond_to do |format|
      if verify_recaptcha
        FeedbackMailer.feedback(params[:feedback]).deliver
        flash[:success] = "Mail sent."
      else
        flash[:error] = "Captcha invalid."
      end
      format.html { redirect_to contact_path }
      format.json { head :ok }
    end
  end

  def privacy
  end

  def authorize
    # do something with the callback
    id = params[:id]
    flash[:success] = 'You are now connected to Fitbit'
    redirect_to root_url
  end

end

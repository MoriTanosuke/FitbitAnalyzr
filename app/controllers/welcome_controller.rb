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
        # make sure devices exist
	if not devices.nil? and not devices[0].nil?
	  @lastSync = devices[0]['lastSyncTime']
          @battery = devices[0]['battery']
       end
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
    if verify_recaptcha
      FeedbackMailer.feedback(params[:feedback]).deliver
      flash[:success] = "Mail sent."
      respond_to do |format|
        format.html { redirect_to contact_path }
        format.json { head :ok }
      end
    else
      flash[:error] = "Captcha invalid."
      respond_to do |format|
        format.html { redirect_to :back, :feedback => params[:feedback] }
        format.json { render :status => :unprocessable_entity }
      end
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

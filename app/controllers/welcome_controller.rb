require 'json'

class WelcomeController < ApplicationController
  skip_before_filter :authorize
  def index
    @user = current_user
    if not @user.fitbit.nil?
      devices = JSON.parse(@user.fitbit.client.get('/1/user/-/devices.json', { 'Accept' => 'application/json' }).body)
      @lastSync = devices[0]['lastSyncTime']
      @battery = devices[0]['battery']
    end
  end

  def authorize
    # do something with the callback
    id = params[:id]
    puts "received id=#{id}"
    redirect_to root_url
  end

end

class WelcomeController < ApplicationController
  skip_before_filter :authorize
  def index
  end

  def authorize
    # do something with the callback
    id = params[:id]
    puts "received id=#{id}"
  end

end

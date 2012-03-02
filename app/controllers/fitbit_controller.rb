class FitbitController < ApplicationController

  def reload(series, date)
    logger.info "reloading series: " + series + " starting at: " + date
    if not current_user.fitbit.nil?
      begin
        JSON.parse(current_user.fitbit.client.get('/1/user/-/' + series + '/date/' + date + '/today.json').body)
      rescue SocketError
        logger.error "Can not talk to fitbit"
        nil
      end
    end
  end

end

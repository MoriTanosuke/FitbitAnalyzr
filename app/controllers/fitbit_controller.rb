class FitbitController < ApplicationController

  def reload(series, date)
    api = {}
    series.each do |s|
      if not current_user.fitbit.nil?
        begin
          data = JSON.parse(current_user.fitbit.client.get('/1/user/-/' + s + '/date/' + date + '/today.json').body)
          api = api.merge(data)
        rescue SocketError
          logger.error "Can not talk to fitbit"
          nil
        end
      end
    end
    tapi = {}
    api.each do |a|
      tapi = tapi.merge(a[0].gsub('-', '/') => a[1])
    end
    logger.info tapi
    return tapi
  end

end
